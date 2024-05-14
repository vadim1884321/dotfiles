#Requires -RunAsAdministrator

iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/vadim1884321/dotfiles/main/windows/helpers.ps1'))

Write-Section -Text "Test installing..." -Color Green
