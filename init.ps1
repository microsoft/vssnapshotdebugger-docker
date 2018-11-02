# Create a pre-commit hook if one does not already exist.
# This hook is generic and it invokes the real hook script at scripts\hooks\pre-commit.ps1
$repositoryRoot=$PSScriptRoot
$preCommitPath="$repositoryRoot\.git\hooks\pre-commit"
if (!(Test-Path "$preCommitPath")) {
    Copy-Item -Path "$repositoryRoot\scripts\hooks\pre-commit" -Destination "$preCommitPath"
}
