# Configuration Item

### Discovery
```
function Check {
    [CmdletBinding()]
    param(
        [String]
        $Path
    )

    $present = (Get-ItemProperty -Path $path | Where-Object { $_.DisplayName -eq 'System Center Endpoint Protection' }).DisplayVersion

    if($present) {
        return $true
    } else {
        return $false
    }
}

$wow = Check -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$win32 = Check -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"

if($wow -or $win32) {
    return $true
} else {
    return $false
}

```

### Remediation

```
Start-Process "C:\Windows\ccmsetup\scepinstall.exe" -ArgumentList "/u", "/s" -WindowStyle Hidden -Wait
```
