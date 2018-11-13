param(
    [Parameter(Mandatory = $false)]
    [switch] $StageChanges
)

$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'

Import-Module "$PSScriptRoot\Common.psm1" -Force -Verbose:$false

$repositoryRoot = Get-RepositoryRoot
$readmeContent = Get-Content -Path "$repositoryRoot\templates\README.md.template" -Raw

$latestRelease = Get-ReleaseData | Sort-Object -Property "version" -Descending | Select-Object -First 1
$latestReleaseTable = Get-ReleaseTable -Release $latestRelease -HeaderSize 3
$readmeContent = $readmeContent.Replace('${LatestReleaseTable}', $latestReleaseTable)

Set-ContentAndStage -Path "$repositoryRoot\README.md" -Content $readmeContent -Stage:$StageChanges
