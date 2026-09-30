param([string]$DeviceId)
$ErrorActionPreference = 'Stop'
$adbPath = Join-Path $env:LOCALAPPDATA 'Android\sdk\platform-tools\adb.exe'
if (-not (Test-Path -LiteralPath $adbPath)) {
    $adbPath = (Get-Command adb -ErrorAction Stop).Source
}
$health = Invoke-RestMethod 'http://127.0.0.1:8000/api/health' -TimeoutSec 5
if ($health.service -ne 'daily-coffee-api' -or $health.status -ne 'ok') {
    throw 'Backend Daily Coffee belum siap. Jalankan php artisan serve di folder backend.'
}
if (-not $DeviceId) {
    $devices = @(& $adbPath devices | Where-Object { $_ -match '^([^\s]+)\s+device$' } | ForEach-Object { ($_ -split '\s+')[0] })
    if ($devices.Count -ne 1) { throw 'Hubungkan satu HP/emulator dengan USB debugging, atau gunakan -DeviceId.' }
    $DeviceId = $devices[0]
}
& $adbPath -s $DeviceId reverse tcp:8000 tcp:8000
if ($LASTEXITCODE -ne 0) { throw 'ADB reverse gagal.' }
Write-Host 'Koneksi USB backend siap. Biarkan server Laravel dan USB tetap aktif.'
