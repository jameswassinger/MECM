[CmdletBinding()]
param (
    [Parameter()]
    [System.IO.FileInfo]
    $Log = "$($env:windir)\Temp\scep-removal.log"
)

function PSExit {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]
        $Message = "An unexpected error has occurred!"
    )

    Write-Host $Message
    throw $Message
}

if (Test-Path -Path $Log) {
    Remove-Item -Path $Log -Force
}


& {
    Write-Host "---------- Start $(Get-Date) ----------"
    $scepInstaller = "C:\Windows\ccmsetup\scepinstall.exe"
    $scepArgs = "/u /s"
    $scepProcName = "MsMpEng"

    $isScepRunning = (Get-Process -Name $scepProcName -ErrorAction SilentlyContinue)

    if($isScepRunning) {
        Write-Host "Scep service is running."
        if(Test-Path -Path $scepInstaller) {
            Write-Host "Scep install found. Initiating uninstall."
            try {
                Start-Process -FilePath $scepInstaller -ArgumentList $scepArgs -Wait -ErrorAction Stop
            } catch {
                PSExit -Message "Failed to uninstall scep! $($_)"
            }
        } else {
            Write-Host "Scep install does not exist."
        }
    } else {
        Write-Host "Scep service is not running."
    }

    Write-Host "---------- End $(Get-Date) ----------"

} *>> $Log
