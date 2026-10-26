param(
    [string]$TvHost = "192.168.1.3"
)
$env:TV_HOST = $TvHost
powershell -ExecutionPolicy Bypass -File tools\restore.ps1 examples\thomson-path-7xpro\debloat.txt com.google.android.tvlauncher
