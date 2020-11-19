#! /usr/bin/env pwsh
param (
    [Parameter(Mandatory)]
    [string]
    $Repository,
    [Parameter(Mandatory)]
    [string]
    $File,
    [string]
    $Version = "latest",
    [string]
    $OutPath = "."
)

$releases = Invoke-RestMethod "https://api.github.com/repos/$Repository/releases/$version"
$asset = $releases.assets | Where-Object name -EQ $File
if (-not (Test-Path $OutPath)) {
    New-Item $OutPath -ItemType Directory
}
$ProgressPreference = "SilentlyContinue"
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile (Join-Path $OutPath $File)
