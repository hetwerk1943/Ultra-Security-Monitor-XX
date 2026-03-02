<# 
Ultra Security Monitor X – Core Engine
MIT License – 2026 LifeHub Team
#>

param(
    [string]$Mode = "Standard"
)

# ====== GLOBAL CONFIG ======
$Global:LogFile        = "$PSScriptRoot\security.log"
$Global:ReportFile     = "$PSScriptRoot\security-report.txt"
$Global:SIEMFile       = "$PSScriptRoot\SIEM\siem.json"
$Global:BackupFolder   = "$PSScriptRoot\Backup"
$Global:DiscordWebhook = ""
$Global:VirusTotalKey  = ""
$Global:MonitoredFolders = @(
    "$env:windir\System32",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Desktop"
)

if (!(Test-Path $BackupFolder)) { New-Item -ItemType Directory -Path $BackupFolder | Out-Null }
if (!(Test-Path "$PSScriptRoot\SIEM")) { New-Item -ItemType Directory -Path "$PSScriptRoot\SIEM" | Out-Null }

# ====== LOGGING ======
function Write-Log {
    param($Message, $Level="INFO")

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "$timestamp`t$Level`t$Message"
    Add-Content -Path $LogFile -Value $entry

    $json = @{
        timestamp = $timestamp
        level     = $Level
        message   = $Message
    } | ConvertTo-Json -Compress

    Add-Content -Path $SIEMFile -Value $json
}

# ====== PROCESS MONITOR ======
Register-WmiEvent -Class Win32_ProcessStartTrace -SourceIdentifier "ProcessStart" -Action {
    $proc = $Event.SourceEventArgs.NewEvent
    $path = (Get-Process -Id $proc.ProcessID -ErrorAction SilentlyContinue).Path

    if ($path) {
        $hash = (Get-FileHash $path -Algorithm SHA256).Hash
        $sig  = Get-AuthenticodeSignature $path

        Write-Log "Process started: $($proc.ProcessName) | Hash: $hash | Signed: $($sig.Status)"
    }
}

# ====== FILE MONITOR ======
foreach ($folder in $MonitoredFolders) {
    $watcher = New-Object IO.FileSystemWatcher $folder -Property @{
        IncludeSubdirectories = $true
        EnableRaisingEvents = $true
    }

    Register-ObjectEvent $watcher Changed -Action {
        $file = $Event.SourceEventArgs.FullPath
        Write-Log "File modified: $file" "WARN"

        $backup = Join-Path $BackupFolder (Split-Path $file -Leaf)
        Copy-Item $file $backup -ErrorAction SilentlyContinue
    }
}

# ====== NETWORK MONITOR ======
function Check-NetworkConnections {
    $connections = Get-NetTCPConnection -State Established
    foreach ($conn in $connections) {
        Write-Log "Network connection: $($conn.RemoteAddress):$($conn.RemotePort)"
    }
}

# ====== MAIN LOOP ======
Write-Log "Ultra Security Monitor X started in mode: $Mode"
while ($true) {
    Check-NetworkConnections
    Start-Sleep -Seconds 15
}
