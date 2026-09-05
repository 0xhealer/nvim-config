Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
Set-StrictMode -Version Latest
$nvim_config="$env:LOCALAPPDATA\nvim"
$nvim_bkp_config="$env:LOCALAPPDATA\nvim-bkp"



$Packages=@(
    "Microsoft.PowerShell"
    "Microsoft.WindowsTerminal"
    "Git.Git"
    "BurntSushi.ripgrep.MSVC"
    "sharkdp.fd"
    "GnuWin32.UnZip"
    "OpenJS.NodeJS.LTS"
    "Python.Python.3.12"
    "Rustlang.Rust.MSVC"
    "Neovim.Neovim"
)

# Ensures the winget sources are fresh
winget source update --disable-interactivity

foreach ($Package in $Packages)
{
    winget install `
        --id $Package `
        -e `
        --source winget `
        --accept-source-agreements `
        --accept-package-agreements `
        --silent
}

# Check the nvim version
nvim --version

# Installing scoop to install gcc

if (Get-Command scoop -ErrorAction SilentlyContinue)
{
    echo "Scoop already installed"
} else
{

    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

scoop bucket add extras

scoop install gcc cmake make

# Copy the nvim folder to AppData/Local/

if (Test-Path -Path $nvim_bkp_config)
{
    Remove-Item -Recurse -Force $nvim_bkp_config
}

if (Test-Path -Path $nvim_config)
{
    Move-Item $nvim_config $nvim_bkp_config
}
Copy-Item -Recurse $PSScriptRoot\nvim $nvim_config
