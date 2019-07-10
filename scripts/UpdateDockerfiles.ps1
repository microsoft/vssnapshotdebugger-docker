param(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string] $DotNetVersion = "*.*",

    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string] $NewSnapshotDebuggerVersion = "",

    [Parameter(Mandatory = $false)]
    [switch] $StageChanges
)

$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

Import-Module "$PSScriptRoot\Common.psm1" -Force -Verbose:$false

$ArgVersionPrefix = 'ARG VSSNAPSHOTDEBUGGER_VERSION='
$ArgVersionRegex = [regex]"$ArgVersionPrefix(?<Version>\d+\.\d+\.\d+)"
$ArgChecksumPrefix = 'ARG VSSNAPSHOTDEBUGGER_SHA512='
$ArgChecksumRegex = [regex]"$ArgChecksumPrefix[0-9a-f]{128}"

$repositoryRoot = Get-RepositoryRoot

$releases = Get-ReleaseData

Get-ChildItem -Path "$repositoryRoot\$DotNetVersion" -Include Dockerfile -Recurse | ForEach-Object {
    Push-Location $repositoryRoot
    $dockerfilePath = $_.FullName
    $dockerfileRelativePath = Resolve-Path -Path $dockerfilePath -Relative
    Pop-Location

    $content = Get-Content $dockerfilePath -Raw

    # Get existing Snasphot Debugger version
    $versionMatch = $ArgVersionRegex.Match($content)
    if (!$versionMatch.Success) {
        Write-Error "Unable to determine Snapshot Debugger version in Dockerfile '$dockerfileRelativePath'."
    }
    $version = [System.Version]$versionMatch.Groups['Version'].Value

    # Update Snapshot Debugger version
    if ($NewSnapshotDebuggerVersion) {
        Write-Verbose "Updating Snapshot Debugger version to ${NewSnapshotDebuggerVersion} in Dockerfile '$dockerfileRelativePath'."
        $content = $ArgVersionRegex.Replace($content, "${ArgVersionPrefix}${NewSnapshotDebuggerVersion}")
        $version = [System.Version]$NewSnapshotDebuggerVersion
    }

    # Determine which release the Dockerfile is referencing
    $release = $releases | Where-Object { $_.version -eq $version } | Select-Object -First 1
    if (!$release) {
        Write-Error "Dockerfile '$dockerfileRelativePath' does not correspond to a release."
    } elseif (!$release.files) {
        Write-Error "Release ${$release.version} does not have files."
    } else {
        # Update information about each release file in the Dockerfile
        $release.files | ForEach-Object {
            $releaseFile = $_
            $candidateUri = Format-ReleaseTokens -Value $releaseFile.uri -Version '${VSSNAPSHOTDEBUGGER_VERSION}'
            # Check if the Dockerfile contains the release file
            if ($content.Contains($candidateUri)) {
                # Update the checksum value of the release file
                $checksumMatch = $ArgChecksumRegex.Match($content)
                if (!$checksumMatch.Success) {
                    Write-Error "Unable to find checksum location in Dockerfile '$dockerfileRelativePath'."
                } elseif ($checksumMatch.Value -ne "${ArgChecksumPrefix}$($releaseFile.sha512)") {
                    Write-Verbose "Updating checksum of file '${candidateUri}' in Dockerfile '$dockerfileRelativePath'."
                    $content = $ArgChecksumRegex.Replace($content, "${ArgChecksumPrefix}$($releaseFile.sha512)")
                }
            }
        }
    }

    Set-ContentAndStage -Path $dockerfilePath -Content $content -Stage:$StageChanges
}
