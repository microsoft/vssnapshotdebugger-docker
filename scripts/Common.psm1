
function Get-ReleaseTable() {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [PSCustomObject] $Release,

        [Parameter(Mandatory = $false)]
        [Int32] $HeaderSize = 0
    )

    $tableBuilder = New-Object -TypeName System.Text.StringBuilder
    if ($HeaderSize -gt 0) {
        [void]$tableBuilder.Append((New-Object -TypeName System.String -ArgumentList '#',$HeaderSize))
        [void]$tableBuilder.Append(' ')
    }
    [void]$tableBuilder.Append('Version: ')
    [void]$tableBuilder.AppendLine($Release.version)
    [void]$tableBuilder.AppendLine('File Name | Description')
    [void]$tableBuilder.AppendLine(':---------|:-----------')

    $rowsBuilder = New-Object -TypeName System.Text.StringBuilder
    $Release.files | ForEach-Object {
        $releaseFile = $_
    
        if ($rowsBuilder.Length -gt 0) {
            [void]$rowsBuilder.AppendLine()
        }
    
        $fileName = Format-ReleaseTokens -Value $releaseFile.name -Version $Release.version
        [void]$rowsBuilder.Append('[')
        [void]$rowsBuilder.Append($fileName)
        [void]$rowsBuilder.Append(']')
    
        $fileUri = Format-ReleaseTokens -Value $releaseFile.uri -Version $Release.version
        [void]$rowsBuilder.Append('(')
        [void]$rowsBuilder.Append($fileUri)
        [void]$rowsBuilder.Append(')')
    
        [void]$rowsBuilder.Append(' | ')
        [void]$rowsBuilder.Append($releaseFile.description)
    }
    [void]$tableBuilder.Append($rowsBuilder.ToString())

    return $tableBuilder.ToString()
}
function Format-ReleaseTokens() {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Value,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Version
    )

    return $Value.Replace('${Version}', $Version)
}

function Get-ReleaseData() {
    $releasesPath = Join-Path -Path (Get-RepositoryRoot) -ChildPath "releases.json" -Resolve
    return (Get-Content -Path $releasesPath -Raw | ConvertFrom-Json).releases
}

function Get-RepositoryRoot() {
    return Resolve-Path -Path "$PSScriptRoot\.."
}

function Set-ContentAndStage() {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Path,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Content,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [switch] $Stage
    )

    [System.IO.File]::WriteAllText($Path, $Content)

    if ($Stage) {
        & git add $Path
    }
}
