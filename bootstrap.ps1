
$RepoZip = "https://github.com/0xhealer/nvim-config/archive/refs/heads/main.zip"
$InstallDir = "$env:LOCALAPPDATA\nvim-config"
$TempZip = "$env:TEMP\nvim-config.zip"
$TempExtract = "$env:TEMP\nvim-config-extract"

if (Test-Path $InstallDir)
{
    Remove-Item -Recurse -Force $InstallDir
}
if (Test-Path $TempExtract)
{
    Remove-Item -Recurse -Force $TempExtract
}

Invoke-WebRequest -Uri $RepoZip -OutFile $TempZip
Expand-Archive -Path $TempZip -DestinationPath $TempExtract -Force
Move-Item "$TempExtract\nvim-config-main" $InstallDir
Remove-Item $TempZip
Remove-Item -Recurse -Force $TempExtract

& "$InstallDir\install.ps1"
