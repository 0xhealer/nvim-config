# nvim-config bootstrap — usage:
#   irm https://raw.githubusercontent.com/0xhealer/nvim-config/main/bootstrap.ps1 | iex
#
# Downloads the repo (zip) and hands off to install.ps1.

$RepoZip = "https://github.com/0xhealer/nvim-config/archive/refs/heads/main.zip"
$InstallDir = "$env:LOCALAPPDATA\nvim-config"
$TempZip = "$env:TEMP\nvim-config.zip"
$TempExtract = "$env:TEMP\nvim-config-extract"

if (Test-Path $InstallDir) {
    Remove-Item -Recurse -Force $InstallDir
}
if (Test-Path $TempExtract) {
    Remove-Item -Recurse -Force $TempExtract
}

Invoke-WebRequest -Uri $RepoZip -OutFile $TempZip
Expand-Archive -Path $TempZip -DestinationPath $TempExtract -Force
Move-Item "$TempExtract\nvim-config-main" $InstallDir
Remove-Item $TempZip
Remove-Item -Recurse -Force $TempExtract

# Run as a real file, not through iex — install.ps1 needs $PSScriptRoot to
# find its own nvim/ folder, which only works when invoked this way.
& "$InstallDir\install.ps1"
