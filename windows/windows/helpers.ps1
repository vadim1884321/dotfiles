. ~\dotfiles\dotfiles-windows\helpers.ps1

function Set-OEMInformation {
	Write-Host "Setting OEM information (Registry)" -ForegroundColor "Green";

    $OEMRegPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\OEMInformation"

		Set-ItemProperty -Path $OEMRegPath -Name Model -Value "SER"
    Set-ItemProperty -Path $OEMRegPath -Name Manufacturer -Value "AZW"
		Set-ItemProperty -Path $OEMRegPath -Name SupportURL -Value "http://www.bee-link.com/"
    # Set-ItemProperty -Path $OEMRegPath -Name SupportPhone -Value "111111"
    Set-ItemProperty -Path $OEMRegPath -Name SupportHours -Value "Always"
    Set-ItemProperty -Path $OEMRegPath -Name HelpCustomized -Value 0
}

function Set-Classic-ContextMenu-Configuration
{
    Write-Host "Activating classic Context Menu:" -ForegroundColor "Green";

    $RegPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}";
    $RegKey = "(Default)";

    if (-not (Test-Path -Path $RegPath))
    {
        New-Item -Path $RegPath;
    }

    $RegPath = $RegPath | Join-Path -ChildPath "InprocServer32";

    if (-not (Test-Path -Path $RegPath))
    {
        New-Item -Path $RegPath;
    }

    if (-not (Test-PathRegistryKey -Path $RegPath -Name $RegKey))
    {
        New-ItemProperty -Path $RegPath -Name $RegKey -PropertyType String;
    }
    Set-ItemProperty -Path $RegPath -Name $RegKey -Value "";

    Write-Host "Classic Context Menu successfully activated." -ForegroundColor "Green";
}

function Set-Power-Configuration
{
    Write-Host "Configuring power plan:" -ForegroundColor "Green";
    # AC: Alternating Current (Wall socket).
    # DC: Direct Current (Battery).

    # Set turn off disk timeout (in minutes / 0: never)
    powercfg -change "disk-timeout-ac" 0;
    powercfg -change "disk-timeout-dc" 0;

    # Set hibernate timeout (in minutes / 0: never)
    powercfg -change "hibernate-timeout-ac" 0;
    powercfg -change "hibernate-timeout-dc" 0;

    # Set sleep timeout (in minutes / 0: never)
    powercfg -change "standby-timeout-ac" 0;
    powercfg -change "standby-timeout-dc" 0;

    # Set turn off screen timeout (in minutes / 0: never)
    powercfg -change "monitor-timeout-ac" 30;
    powercfg -change "monitor-timeout-dc" 10;

    # Set turn off screen timeout on lock screen (in seconds / 0: never)
    powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 30;
    powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 30;
    powercfg /SETACTIVE SCHEME_CURRENT;

    Write-Host "Power plan successfully updated." -ForegroundColor "Green";
}

function Rename-PC($computer_name)
{
    if ($env:COMPUTERNAME -ne $computer_name)
    {
        Write-Host "Renaming PC:" -ForegroundColor "Green";

        Rename-Computer -NewName $computer_name -Force;

        Write-Host "PC renamed, restart it to see the changes." -ForegroundColor "Green";
    } else
    {
        Write-Host "The PC name is $computer_name it is not necessary to rename it." -ForegroundColor "Green";
    }
}

function Get-WindowsFeature-Installation-Status
{
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $TRUE)]
        [string]
        $FeatureName
    )

    if ((Get-WindowsOptionalFeature -FeatureName $FeatureName -Online).State -eq "Enabled")
    {
        return $TRUE;
    } else
    {
        return $FALSE;
    }
}

function Disable-WindowsFeature
{
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $FeatureKey,

        [Parameter( Position = 1, Mandatory = $TRUE)]
        [String]
        $FeatureName
    )

    if (Get-WindowsFeature-Installation-Status $FeatureKey)
    {
        Write-Host "Disabling" $FeatureName ":" -ForegroundColor "Green";
        Disable-WindowsOptionalFeature -FeatureName $FeatureKey -Online -NoRestart;
    } else
    {
        Write-Host $FeatureName "is already disabled." -ForegroundColor "Green";
    }
}

function Enable-WindowsFeature
{
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $FeatureKey,

        [Parameter( Position = 1, Mandatory = $TRUE)]
        [String]
        $FeatureName
    )

    if (-not (Get-WindowsFeature-Installation-Status $FeatureKey))
    {
        Write-Host "Enabling" $FeatureName ":" -ForegroundColor "Green";
        Enable-WindowsOptionalFeature -FeatureName $FeatureKey -Online -All -NoRestart;
    } else
    {
        Write-Host $FeatureName "is already enabled." -ForegroundColor "Green";
    }
}

function Test-PathRegistryKey
{
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $Path,

        [Parameter( Position = 1, Mandatory = $TRUE)]
        [String]
        $Name
    )

    try
    {
        $Reg = Get-ItemPropertyValue -Path $Path -Name $Name;
        Return $TRUE;
    } catch
    {
        Return $FALSE;
    }
}

function Set-PSDrive-HKCR
{
    Write-Host "Setting alias of HKEY_CLASSES_ROOT:" -ForegroundColor "Green";
    New-PSDrive -PSProvider "registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -Scope global;
}

function Uninstall-AppPackage
{
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $Name
    )

    try
    {
        Get-AppxPackage $Name -AllUsers | Remove-AppxPackage;
        Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like $Name | Remove-AppxProvisionedPackage -Online;
    } catch
    {

    }
}
