param(
    [Parameter(Mandatory = $false)]
    [switch] $StageChanges
)

$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

Import-Module "$PSScriptRoot\Common.psm1" -Force -Verbose:$false

$repositoryRoot = Get-RepositoryRoot

$builder = New-Object -TypeName System.Text.StringBuilder

# Write checksums groups by release version descending.
Get-ReleaseData | Sort-Object -Property "version" -Descending | ForEach-Object {
    $release = $_

    if ($builder.Length -gt 0) {
        [void]$builder.AppendLine();
    }

    # Add two lines for the version and the hash algorithm
    $version = $release.version
    [void]$builder.Append('Version: ')
    [void]$builder.AppendLine($version)
    [void]$builder.AppendLine('Hash: SHA512')
    [void]$builder.AppendLine();

    # Add a line for each release file.
    # Each of these lines can be copy-and-pasted directly into scripts for checksum verification
    # since the sha512sum executable verifies the checksum in the format "<checksum>  <filename>".
    $release.files | ForEach-Object {
        $releaseFile = $_
        # Write checksum value
        [void]$builder.Append($releaseFile.sha512)

        # Two spaces is intentional
        [void]$builder.Append('  ')

        # Write file name
        $releaseFileName = Format-ReleaseTokens -Value $releaseFile.name -Version $release.version
        [void]$builder.AppendLine($releaseFilename)
    }
}

Set-ContentAndStage -Path "$repositoryRoot\CHECKSUMS" -Content $builder.ToString() -Stage:$StageChanges
