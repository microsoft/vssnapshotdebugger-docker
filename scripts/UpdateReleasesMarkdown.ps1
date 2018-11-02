param(
    [Parameter(Mandatory = $false)]
    [switch] $StageChanges
)

$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

Import-Module "$PSScriptRoot\Common.psm1" -Force -Verbose:$false

$repositoryRoot = Get-RepositoryRoot
$releasesContent = Get-Content -Path "$repositoryRoot\templates\RELEASES.md.template" -Raw

$releases = Get-ReleaseData | Sort-Object -Property "version" -Descending
$latestRelease = $releases | Select-Object -First 1

$latestReleaseTable = Get-ReleaseTable -Release $latestRelease -HeaderSize 3
$releasesContent = $releasesContent.Replace('${LatestReleaseTable}', $latestReleaseTable)

$previousReleasesBuilder = New-Object -TypeName System.Text.StringBuilder
$previousReleases = $releases | Select-Object -Skip 1
if ($previousReleases.Count -gt 0) {
    $previousReleases | ForEach-Object {
        $previousRelease = $_

        if ($previousReleasesBuilder.Length -gt 0) {
            [void]$previousReleasesBuilder.AppendLine()
            [void]$previousReleasesBuilder.AppendLine()
        }

        $previousReleaseTable = Get-ReleaseTable -Release $previousRelease -HeaderSize 3
        [void]$previousReleasesBuilder.Append($previousReleaseTable)
    }
}
$releasesContent = $releasesContent.Replace('${PreviousReleaseTables}', $previousReleasesBuilder.ToString())

Set-ContentAndStage -Path "$repositoryRoot\RELEASES.md" -Content $releasesContent -Stage:$StageChanges
