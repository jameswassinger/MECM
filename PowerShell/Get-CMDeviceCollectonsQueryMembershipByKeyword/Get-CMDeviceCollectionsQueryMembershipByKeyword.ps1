[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [String]
    $SiteCode,

    [Parameter(Mandatory)]
    [String]
    $ProviderMachineName,

    [Parameter(Mandatory)]
    [String[]]
    $QueryKeyword,

    [Parameter()]
    [String]
    $CollectionKeyword
)

function PSExit {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]
        $Message
    )
}


try {

    $Location = "C:\Windows\System32"

    try {
        # Customizations
        $initParams = @{}
        #$initParams.Add("Verbose", $true) # Uncomment this line to enable verbose logging
        #$initParams.Add("ErrorAction", "Stop") # Uncomment this line to stop the script on any errors

        # Do not change anything below this line

        # Import the ConfigurationManager.psd1 module 
        if ((Get-Module ConfigurationManager) -eq $null) {
            Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1" @initParams 
        }

        # Connect to the site's drive if it is not already present
        if ((Get-PSDrive -Name $SiteCode -PSProvider CMSite -ErrorAction SilentlyContinue) -eq $null) {
            New-PSDrive -Name $SiteCode -PSProvider CMSite -Root $ProviderMachineName @initParams
        }

        # Set the current location to be the site code.
        Set-Location "$($SiteCode):\" @initParams

    } catch {
        PSExit "Could not connect to $($ProviderMachineName)! $($_)"
    }

    if($CollectionKeyword) {
        $Collections = Get-CMDeviceCollection | Where-Object { $_.Name -like "*$CollectionKeyword*"}
    } else {
        $Collections = Get-CMDeviceCollection
    }

    $Count = 0
    $Collections | ForEach-Object {
        $CollectionObj = $_
        $QueryObj = Get-CMDeviceCollectionQueryMembershipRule -CollectionName $CollectionObj.Name

        $QueryKeyword | ForEach-Object {
            $Keyword = $_
            if($QueryObj.QueryExpression -like "*$Keyword*") {
                $Count += 1
                Write-Host $Count
                Write-Host "Collection Name = $($CollectionObj.Name)"
                Write-Host "QueryExpression = $($QueryObj.QueryExpression)"
                Write-Host "--------------------`n"
            }
        }
    }

    try {
        Set-Location -Path $Location -ErrorAction Stop
    } catch {
        PSExit "Failed to set the location to $($Location). $($_)"
    }
} catch {
    PSExit "An unexpected error has occurred! $($_)"
}


