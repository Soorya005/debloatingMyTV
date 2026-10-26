# Thomson Smart TV PATH_7XPRO (Android TV 9)

- **Device**: Thomson Smart TV 32" (SPPL / Amlogic SoC, `model PATH_7XPRO`, `device LEDTV32HD`)
- **OS**: Android TV 9 (API level 28), build `PI.20210601 release-keys`
- **RAM**: ~1 GB
- **Stock Launcher**: `com.google.android.tvlauncher` (Android TV Home)
- **New Launcher**: Native Apple TV 4K-style Leanback launcher (`com.gathin.tvhome`)

---

## What was changed

1. **Debloating (22 packages safely disabled)**:
   - SPPL e-manual and Amlogic auto-installer (`com.sppl.emanual`, `android.autoinstalls.config.amlogic.device`)
   - Sponsored ads and recommendation feed (`com.google.android.tvrecommendations`, `com.google.android.leanbacklauncher.recommendations`, `com.droidlogic.launcher.provider`)
   - Partner customizer, feedback, bug report telemetry (`com.google.android.tvsetup.partnercustomizer`, `com.google.android.partnersetup`, `com.google.android.feedback`, `com.google.android.tv.bugreportsender`)
   - Stock media duplicate players (`com.ctv.music`, `com.ctv.photoplayer`, `com.droidlogic.videoplayer`)
   - Defunct services & unused sync adapters (`com.google.android.music`, `com.google.android.play.games`, `com.google.android.youtube.tvmusic`, `com.google.android.marvin.talkback`, calendar/contacts providers)

2. **Apps & Features Kept Active**:
   - Streaming: YouTube, Disney+ Hotstar, Prime Video, JioCinema, Sony LIV
   - Utilities: TV Browser, File Manager (`com.yunfang.files`), Live TV (`com.droidlogic.droidlivetv`)
   - Core Features: Google Assistant (`com.google.android.katniss`), Chromecast (`mediashell`), OTA Updates (`com.droidlogic.otaupgrade`), Play Store & Play Services

3. **Ad-blocking Private DNS**:
   - Set to `dns.adguard-dns.com` (`hostname` mode) to block domain-level tracker ads and popup telemetry across all apps.

4. **Apple TV-Style Launcher**:
   - Pinned 4-slot dock: **YouTube**, **JioHotstar**, **Prime Video**, and **JioCinema**.
   - Dynamic ambient glow and focused banner sampling.
   - Live TV tuner and inputs integration under the top frosted glass pill.

---

## How to Re-enable Any Disabled App

To restore any specific package (e.g. YouTube Music or Cricfy TV):
```powershell
$env:TV_HOST = "192.168.1.3"
tools\venv\Scripts\python.exe tools\tv.py "pm enable --user 0 <package.name>"
```

Example to re-enable YouTube Music:
```powershell
tools\venv\Scripts\python.exe tools\tv.py "pm enable --user 0 com.google.android.youtube.tvmusic"
```

---

## Full Restore to Stock

To completely revert all debloated packages and return to the stock Android TV launcher:
```powershell
$env:TV_HOST = "192.168.1.3"
powershell -ExecutionPolicy Bypass -File tools\restore.ps1 examples\thomson-path-7xpro\debloat.txt com.google.android.tvlauncher
```

---

## How to Change Dock Apps or Order

1. Open `launcher\app\src\main\res\values\config.xml`.
2. Edit the `<string-array name="dock_apps">` block:
   ```xml
   <string-array name="dock_apps">
       <item>com.google.android.youtube.tv</item>
       <item>in.startv.hotstar</item>
       <item>com.amazon.amazonvideo.livingroom</item>
       <item>com.jio.media.stb.ondemand</item>
   </string-array>
   ```
3. Rebuild and install:
   ```powershell
   $env:JAVA_HOME = "C:\Program Files\Microsoft\jdk-17.0.20.101-hotspot"
   $env:TV_HOST = "192.168.1.3"
   powershell -ExecutionPolicy Bypass -File launcher\build-and-install.ps1 -TvHost 192.168.1.3
   ```

---

## How to Change Wallpaper or Themes

You can push any preset theme or your own custom wallpaper from `themes/`:
```powershell
$env:TV_HOST = "192.168.1.3"
powershell -ExecutionPolicy Bypass -File tools\theme.ps1 themes\glass
```
To set a custom wallpaper picture:
```powershell
tools\venv\Scripts\python.exe tools\b64push.py my-wallpaper.jpg /sdcard/Android/data/com.gathin.tvhome/files/wallpaper.jpg
tools\venv\Scripts\python.exe tools\tv.py "am force-stop com.gathin.tvhome"
```

---

## Undo Private DNS

If you ever wish to turn off Private DNS:
```powershell
$env:TV_HOST = "192.168.1.3"
tools\venv\Scripts\python.exe tools\tv.py "settings put global private_dns_mode opportunistic"
```

---

## Finishing Up: Security Recommendation

Now that setup is complete:
1. On the TV, go to **Settings → Device Preferences → Developer options**.
2. Turn OFF **USB debugging**.
3. (Optional) Select **Revoke USB debugging authorizations**.
This closes port 5555 so no unauthorized device on your network can access your TV.
