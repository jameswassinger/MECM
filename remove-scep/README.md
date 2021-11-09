# Removing System Center Endpoint Protection

Disable Windows Defender
```
Set-MpPreference -DisableRealtimeMonitoring $true
```

Uninstall SCEP
```
Start-Process "C:\Windows\ccmsetup\scepinstall.exe" -ArgumentList "/u", "/s" -WindowStyle Hidden -Wait
```
