$ErrorActionPreference = "Stop"

$pyInstalled = $false

try {
    py --version | Out-Null
    $pyInstalled = $true
} catch {}

if (-not $pyInstalled) {
    $installer = "$env:TEMP\python-installer.exe"

    Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.12.4/python-3.12.4-amd64.exe" -OutFile $installer

    Start-Process $installer -Wait -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 Include_pip=1 Include_launcher=1 InstallLauncherAllUsers=1"

    Remove-Item $installer -Force

    Start-Sleep 5
}

py -m pip install --upgrade pip
py -m pip install -r .\Runtime\requirements.txt
clear
py .\Runtime\Camerasender.py

Read-Host "Enter something"