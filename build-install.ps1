param(
    [string]$TvHost = "192.168.1.3"
)
$env:JAVA_HOME = "C:\Program Files\Microsoft\jdk-17.0.20.101-hotspot"
$env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk"
$env:TV_HOST = $TvHost
powershell -ExecutionPolicy Bypass -File launcher\build-and-install.ps1 -TvHost $TvHost
