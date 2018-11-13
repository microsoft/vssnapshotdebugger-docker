$VerbosePreference = 'Continue'

$ScriptsRoot = Resolve-Path -Path "$PSScriptRoot\.."

try
{
    # Update CHECKSUMS file
    & "$ScriptsRoot\UpdateChecksums.ps1" -StageChanges
}
catch
{
    # Catch exception and write to host, but don't fail commit operation
    Write-Host "Exception occured executing pre-commit script UpdateChecksums.ps1: $_"
}

try
{
    # Update Dockerfiles
    & "$ScriptsRoot\UpdateDockerfiles.ps1" -StageChanges
}
catch
{
    # Catch exception and write to host, but don't fail commit operation
    Write-Host "Exception occured executing pre-commit script UpdateDockerfiles.ps1: $_"
}

try
{
    # Update README.md file
    & "$ScriptsRoot\UpdateReadmeMarkdown.ps1" -StageChanges
}
catch
{
    # Catch exception and write to host, but don't fail commit operation
    Write-Host "Exception occured executing pre-commit script UpdateReadmeMarkdown.ps1: $_"
}

try
{
    # Update RELEASES.md file
    & "$ScriptsRoot\UpdateReleasesMarkdown.ps1" -StageChanges
}
catch
{
    # Catch exception and write to host, but don't fail commit operation
    Write-Host "Exception occured executing pre-commit script UpdateReleasesMarkdown.ps1: $_"
}

exit 0
