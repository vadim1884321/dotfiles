# . ~\dotfiles\dotfiles-windows\helpers.ps1

function Set-Power-Configuration {
	Write-Host "Configuring power plan:" -ForegroundColor "Green";
	# AC: Alternating Current (Wall socket).
	# DC: Direct Current (Battery).

	# Set High Performance profile
	powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

	# Disable monitor timeout
	powercfg /change monitor-timeout-ac 30
	powercfg /change monitor-timeout-dc 0

	# Disable standby timeout
	powercfg /change standby-timeout-ac 0
	powercfg /change standby-timeout-dc 0

	# Disable hibernate timeout
	powercfg /change hibernate-timeout-ac 0
	powercfg /change hibernate-timeout-dc 0

	# Disable hibernate
	powercfg /hibernate off

	Write-Host "Power plan successfully updated." -ForegroundColor "Green";
}

function Rename-PC($computer_name) {
	if ($env:COMPUTERNAME -ne $computer_name) {
		Write-Host "Renaming PC:" -ForegroundColor "Green";

		Rename-Computer -NewName $computer_name -Force;

		Write-Host "PC renamed, restart it to see the changes." -ForegroundColor "Green";
	}
 else {
		Write-Host "The PC name is $computer_name it is not necessary to rename it." -ForegroundColor "Green";
	}
}

function Get-WindowsFeature-Installation-Status {
	[CmdletBinding()]
	param(
		[Parameter(Position = 0, Mandatory = $TRUE)]
		[string]
		$FeatureName
	)

	if ((Get-WindowsOptionalFeature -FeatureName $FeatureName -Online).State -eq "Enabled") {
		return $TRUE;
	}
 else {
		return $FALSE;
	}
}

function Disable-WindowsFeature {
	[CmdletBinding()]
	param (
		[Parameter( Position = 0, Mandatory = $TRUE)]
		[String]
		$FeatureKey,

		[Parameter( Position = 1, Mandatory = $TRUE)]
		[String]
		$FeatureName
	)

	if (Get-WindowsFeature-Installation-Status $FeatureKey) {
		Write-Host "Disabling" $FeatureName ":" -ForegroundColor "Green";
		Disable-WindowsOptionalFeature -FeatureName $FeatureKey -Online -NoRestart;
	}
 else {
		Write-Host $FeatureName "is already disabled." -ForegroundColor "Green";
	}
}

function Enable-WindowsFeature {
	[CmdletBinding()]
	param (
		[Parameter( Position = 0, Mandatory = $TRUE)]
		[String]
		$FeatureKey,

		[Parameter( Position = 1, Mandatory = $TRUE)]
		[String]
		$FeatureName
	)

	if (-not (Get-WindowsFeature-Installation-Status $FeatureKey)) {
		Write-Host "Enabling" $FeatureName ":" -ForegroundColor "Green";
		Enable-WindowsOptionalFeature -FeatureName $FeatureKey -Online -All -NoRestart;
	}
 else {
		Write-Host $FeatureName "is already enabled." -ForegroundColor "Green";
	}
}

function Test-PathRegistryKey {
	[CmdletBinding()]
	param (
		[Parameter( Position = 0, Mandatory = $TRUE)]
		[String]
		$Path,

		[Parameter( Position = 1, Mandatory = $TRUE)]
		[String]
		$Name
	)

	try {
		Get-ItemPropertyValue -Path $Path -Name $Name;
		Return $TRUE;
	}
 catch {
		Return $FALSE;
	}
}

function Set-PSDrive-HKCR {
	Write-Host "Setting alias of HKEY_CLASSES_ROOT:" -ForegroundColor "Green";
	New-PSDrive -PSProvider "registry" -Root "HKEY_CLASSES_ROOT" -Name "HKCR" -Scope global;
}

function Uninstall-AppPackage {
	[CmdletBinding()]
	param (
		[Parameter( Position = 0, Mandatory = $TRUE)]
		[String]
		$Name
	)

	try {
		Get-AppxPackage $Name -AllUsers | Remove-AppxPackage;
		Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like $Name | Remove-AppxProvisionedPackage -Online;
	}
 catch {

	}
}

# Enable script logging. The log will be being recorded into the script root folder
# To stop logging just close the console or type "Stop-Transcript"
function Logging {
	$TranscriptFilename = "Log-$((Get-Date).ToString("dd.MM.yyyy-HH-mm"))"
	Start-Transcript -Path $PSScriptRoot\..\$TranscriptFilename.txt -Force
}

# Create a restore point for the system drive
function CreateRestorePoint {
	$SystemDriveUniqueID = (Get-Volume | Where-Object -FilterScript { $_.DriveLetter -eq "$($env:SystemDrive[0])" }).UniqueID
	$SystemProtection = ((Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" -ErrorAction Ignore)."{09F7EDC5-294E-4180-AF6A-FB0E6A0E9513}") | Where-Object -FilterScript { $_ -match [regex]::Escape($SystemDriveUniqueID) }

	$Script:ComputerRestorePoint = $false

	$SystemProtection ?? (& {
			$Script:ComputerRestorePoint = $true
			Enable-ComputerRestore -Drive $env:SystemDrive
		}
	)

	# Never skip creating a restore point
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -PropertyType DWord -Value 0 -Force

	Checkpoint-Computer -Description "Dotfiles for Microsoft Windows 11" -RestorePointType MODIFY_SETTINGS

	# Revert the System Restore checkpoint creation frequency to 1440 minutes
	New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -PropertyType DWord -Value 1440 -Force

	# Turn off System Protection for the system drive if it was turned off before without deleting the existing restore points
	if ($Script:ComputerRestorePoint) {
		Disable-ComputerRestore -Drive $env:SystemDrive
	}
}

<#
	.SYNOPSIS
	Create pre-configured text files for LGPO.exe tool

	.EXAMPLE
	Set-Policy -Scope Computer -Path SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -Type DWORD -Value 0

	.NOTES
	https://techcommunity.microsoft.com/t5/microsoft-security-baselines/lgpo-exe-local-group-policy-object-utility-v1-0/ba-p/701045

	.NOTES
	Machine-wide user
#>
function script:Set-Policy {
	[CmdletBinding()]
	param
	(
		[Parameter(
			Mandatory = $true,
			Position = 1
		)]
		[string]
		[ValidateSet("Computer", "User")]
		$Scope,

		[Parameter(
			Mandatory = $true,
			Position = 2
		)]
		[string]
		$Path,

		[Parameter(
			Mandatory = $true,
			Position = 3
		)]
		[string]
		$Name,

		[Parameter(
			Mandatory = $true,
			Position = 4
		)]
		[ValidateSet("DWORD", "SZ", "EXSZ", "CLEAR")]
		[string]
		$Type,

		[Parameter(
			Mandatory = $false,
			Position = 5
		)]
		$Value
	)

	if (-not (Test-Path -Path "$env:SystemRoot\System32\gpedit.msc")) {
		Write-Information -MessageData "" -InformationAction Continue
		Write-Verbose -Message $Localization.Skipped -Verbose

		return
	}

	switch ($Type) {
		"CLEAR" {
			$Policy = @"
$Scope
$($Path)
$($Name)
$($Type)`n
"@
		}
		default {
			$Policy = @"
$Scope
$($Path)
$($Name)
$($Type):$($Value)`n
"@
		}
	}

	if ($Scope -eq "Computer") {
		$Path = "$env:TEMP\Computer.txt"
	}
	else {
		$Path = "$env:TEMP\User.txt"
	}

	Add-Content -Path $Path -Value $Policy -Encoding Default -Force
}

<#
	.SYNOPSIS
	The Connected User Experiences and Telemetry (DiagTrack) service

	.PARAMETER Disable
	Disable the Connected User Experiences and Telemetry (DiagTrack) service, and block connection for the Unified Telemetry Client Outbound Traffic

	.PARAMETER Enable
	Enable the Connected User Experiences and Telemetry (DiagTrack) service, and allow connection for the Unified Telemetry Client Outbound Traffic

	.EXAMPLE
	DiagTrackService -Disable

	.EXAMPLE
	DiagTrackService -Enable

	.NOTES
	Disabling the "Connected User Experiences and Telemetry" service (DiagTrack) can cause you not being able to get Xbox achievements anymore and affects Feedback Hub

	.NOTES
	Current user
#>
function DiagTrackService {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			# Connected User Experiences and Telemetry
			# Disabling the "Connected User Experiences and Telemetry" service (DiagTrack) can cause you not being able to get Xbox achievements anymore and affects Feedback Hub
			Get-Service -Name DiagTrack | Stop-Service -Force
			Get-Service -Name DiagTrack | Set-Service -StartupType Disabled

			# Block connection for the Unified Telemetry Client Outbound Traffic
			Get-NetFirewallRule -Group DiagTrack | Set-NetFirewallRule -Enabled True -Action Block
		}
		"Enable" {
			# Connected User Experiences and Telemetry
			Get-Service -Name DiagTrack | Set-Service -StartupType Automatic
			Get-Service -Name DiagTrack | Start-Service

			# Allow connection for the Unified Telemetry Client Outbound Traffic
			Get-NetFirewallRule -Group DiagTrack | Set-NetFirewallRule -Enabled True -Action Allow
		}
	}
}

<#
	.SYNOPSIS
	Diagnostic data

	.PARAMETER Minimal
	Set the diagnostic data collection to minimum

	.PARAMETER Default
	Set the diagnostic data collection to default

	.EXAMPLE
	DiagnosticDataLevel -Minimal

	.EXAMPLE
	DiagnosticDataLevel -Default

	.NOTES
	Machine-wide
#>
function DiagnosticDataLevel {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Minimal"
		)]
		[switch]
		$Minimal,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default
	)

	if (-not (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection")) {
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force
	}

	if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack")) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" -Force
	}

	switch ($PSCmdlet.ParameterSetName) {
		"Minimal" {
			if (Get-WindowsEdition -Online | Where-Object -FilterScript { ($_.Edition -eq "Enterprise") -or ($_.Edition -eq "Education") }) {
				# Diagnostic data off
				New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -PropertyType DWord -Value 0 -Force
				Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWORD -Value 0
			}
			else {
				# Send required diagnostic data
				New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -PropertyType DWord -Value 1 -Force
				Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWORD -Value 1
			}

			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "MaxTelemetryAllowed" -PropertyType DWord -Value 1 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" -Name "ShowedToastAtLevel" -PropertyType DWord -Value 1 -Force
		}
		"Default" {
			# Optional diagnostic data
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "MaxTelemetryAllowed" -PropertyType DWord -Value 3 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" -Name "ShowedToastAtLevel" -PropertyType DWord -Value 3 -Force
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Force -ErrorAction Ignore

			Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type CLEAR
		}
	}
}

<#
	.SYNOPSIS
	Windows Error Reporting

	.PARAMETER Disable
	Turn off Windows Error Reporting

	.PARAMETER Enable
	Turn on Windows Error Reporting

	.EXAMPLE
	ErrorReporting -Disable

	.EXAMPLE
	ErrorReporting -Enable

	.NOTES
	Current user
#>
function ErrorReporting {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			if ((Get-WindowsEdition -Online).Edition -notmatch "Core") {
				Get-ScheduledTask -TaskName QueueReporting | Disable-ScheduledTask
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name Disabled -PropertyType DWord -Value 1 -Force
			}

			Get-Service -Name WerSvc | Stop-Service -Force
			Get-Service -Name WerSvc | Set-Service -StartupType Disabled
		}
		"Enable" {
			Get-ScheduledTask -TaskName QueueReporting | Enable-ScheduledTask
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name Disabled -Force -ErrorAction Ignore

			Get-Service -Name WerSvc | Set-Service -StartupType Manual
			Get-Service -Name WerSvc | Start-Service
		}
	}
}

<#
	.SYNOPSIS
	The feedback frequency

	.PARAMETER Never
	Change the feedback frequency to "Never"

	.PARAMETER Automatically
	Change feedback frequency to "Automatically"

	.EXAMPLE
	FeedbackFrequency -Never

	.EXAMPLE
	FeedbackFrequency -Automatically

	.NOTES
	Current user
#>
function FeedbackFrequency {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Never"
		)]
		[switch]
		$Never,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Automatically"
		)]
		[switch]
		$Automatically
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Never" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Siuf\Rules")) {
				New-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -PropertyType DWord -Value 0 -Force
		}
		"Automatically" {
			Remove-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	The sign-in info to automatically finish setting up device after an update

	.PARAMETER Disable
	Do not use sign-in info to automatically finish setting up device after an update

	.PARAMETER Enable
	Use sign-in info to automatically finish setting up device after an update

	.EXAMPLE
	SigninInfo -Disable

	.EXAMPLE
	SigninInfo -Enable

	.NOTES
	Current user
#>
function SigninInfo {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			$SID = (Get-CimInstance -ClassName Win32_UserAccount | Where-Object -FilterScript { $_.Name -eq $env:USERNAME }).SID
			if (-not (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\$SID")) {
				New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\$SID" -Force
			}
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\$SID" -Name OptOut -PropertyType DWord -Value 1 -Force
		}
		"Enable" {
			$SID = (Get-CimInstance -ClassName Win32_UserAccount | Where-Object -FilterScript { $_.Name -eq $env:USERNAME }).SID
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\$SID" -Name OptOut -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	The provision to websites a locally relevant content by accessing my language list

	.PARAMETER Disable
	Do not let websites show me locally relevant content by accessing my language list

	.PARAMETER Enable
	Let websites show me locally relevant content by accessing language my list

	.EXAMPLE
	LanguageListAccess -Disable

	.EXAMPLE
	LanguageListAccess -Enable

	.NOTES
	Current user
#>
function LanguageListAccess {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			New-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -PropertyType DWord -Value 1 -Force
		}
		"Enable" {
			Remove-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	The permission for apps to show me personalized ads by using my advertising ID

	.PARAMETER Disable
	Do not let apps show me personalized ads by using my advertising ID

	.PARAMETER Enable
	Let apps show me personalized ads by using my advertising ID

	.EXAMPLE
	AdvertisingID -Disable

	.EXAMPLE
	AdvertisingID -Enable

	.NOTES
	Current user
#>
function AdvertisingID {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name Enabled -PropertyType DWord -Value 0 -Force
		}
		"Enable" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name Enabled -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	The Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested

	.PARAMETER Hide
	Hide the Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested

	.PARAMETER Show
	Show the Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested

	.EXAMPLE
	WindowsWelcomeExperience -Hide

	.EXAMPLE
	WindowsWelcomeExperience -Show

	.NOTES
	Current user
#>
function WindowsWelcomeExperience {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Show" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -PropertyType DWord -Value 1 -Force
		}
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -PropertyType DWord -Value 0 -Force
		}
	}
}

<#
	.SYNOPSIS
	Ways to get the most out of Windows and finish setting up this device

	.PARAMETER Disable
	Do not suggest ways to get the most out of Windows and finish setting up this device

	.PARAMETER Enable
	Suggest ways to get the most out of Windows and finish setting up this device

	.EXAMPLE
	WhatsNewInWindows -Disable

	.EXAMPLE
	WhatsNewInWindows -Enable

	.NOTES
	Current user
#>
function WhatsNewInWindows {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -PropertyType DWord -Value 0 -Force
		}
		"Enable" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Getting tip and suggestions when I use Windows

	.PARAMETER Enable
	Get tip and suggestions when using Windows

	.PARAMETER Disable
	Do not get tip and suggestions when I use Windows

	.EXAMPLE
	WindowsTips -Enable

	.EXAMPLE
	WindowsTips -Disable

	.NOTES
	Current user
#>
function WindowsTips {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -PropertyType DWord -Value 1 -Force
		}
		"Disable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -PropertyType DWord -Value 0 -Force
		}
	}
}

<#
	.SYNOPSIS
	Show me suggested content in the Settings app

	.PARAMETER Hide
	Hide from me suggested content in the Settings app

	.PARAMETER Show
	Show me suggested content in the Settings app

	.EXAMPLE
	SettingsSuggestedContent -Hide

	.EXAMPLE
	SettingsSuggestedContent -Show

	.NOTES
	Current user
#>
function SettingsSuggestedContent {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -PropertyType DWord -Value 0 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -PropertyType DWord -Value 0 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -PropertyType DWord -Value 0 -Force
		}
		"Show" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -PropertyType DWord -Value 1 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -PropertyType DWord -Value 1 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Automatic installing suggested apps

	.PARAMETER Disable
	Turn off automatic installing suggested apps

	.PARAMETER Enable
	Turn on automatic installing suggested apps

	.EXAMPLE
	AppsSilentInstalling -Disable

	.EXAMPLE
	AppsSilentInstalling -Enable

	.NOTES
	Current user
#>
function AppsSilentInstalling {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -PropertyType DWord -Value 0 -Force
		}
		"Enable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Tailored experiences

	.PARAMETER Disable
	Do not let Microsoft use your diagnostic data for personalized tips, ads, and recommendations

	.PARAMETER Enable
	Let Microsoft use your diagnostic data for personalized tips, ads, and recommendations

	.EXAMPLE
	TailoredExperiences -Disable

	.EXAMPLE
	TailoredExperiences -Enable

	.NOTES
	Current user
#>
function TailoredExperiences {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -PropertyType DWord -Value 0 -Force
		}
		"Enable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Bing search in the Start Menu

	.PARAMETER Disable
	Disable Bing search in the Start Menu

	.PARAMETER Enable
	Enable Bing search in the Start Menu

	.EXAMPLE
	BingSearch -Disable

	.EXAMPLE
	BingSearch -Enable

	.NOTES
	Current user
#>
function BingSearch {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			if (-not (Test-Path -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer")) {
				New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -PropertyType DWord -Value 1 -Force

			Set-Policy -Scope User -Path "Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Type DWORD -Value 1
		}
		"Enable" {
			Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Force -ErrorAction Ignore
			Set-Policy -Scope User -Path "Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Type CLEAR
		}
	}
}

<#
	.SYNOPSIS
	Browsing history in the Start menu

	.PARAMETER Hide
	Do not show websites from your browsing history in the Start menu

	.PARAMETER Show
	Show websites from your browsing history in the Start menu

	.EXAMPLE
	BrowsingHistory -Hide

	.EXAMPLE
	BrowsingHistory -Show

	.NOTES
	Windows 11 build 23451 (Dev) required

	.NOTES
	Current user
#>
function BrowsingHistory {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	if ((Get-CimInstance -ClassName CIM_OperatingSystem).BuildNumber -lt 23451) {
		Write-Information -MessageData "" -InformationAction Continue
		Write-Verbose -Message $Localization.Skipped -Verbose

		return
	}

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_RecoPersonalizedSites" -PropertyType DWord -Value 0 -Force
		}
		"Show" {
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_RecoPersonalizedSites" -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	Add support for JPEG-XL image format thumbnails

	.EXAMPLE
	JXLWinthumb

	.LINK
	https://github.com/saschanaz/jxl-winthumb

	.NOTES
	Current user
#>
function JXLWinthumb {
	try {
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

		# Determining the latest version of the library file
		$tag = (Invoke-WebRequest -Uri "https://api.github.com/repos/saschanaz/jxl-winthumb/releases" -UseBasicParsing | ConvertFrom-Json)[0].tag_name

		# Downloading the latest $tag version of the library file
		$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
		$Parameters = @{
			Uri             = "https://github.com/saschanaz/jxl-winthumb/releases/download/$tag/jxl_winthumb.dll"
			OutFile         = "$DownloadsFolder\jxl_winthumb.dll"
			UseBasicParsing = $true
			Verbose         = $true
		}
		Invoke-WebRequest @Parameters
		Start-Process regsvr32.exe -ArgumentList "/s $DownloadsFolder\jxl_winthumb.dll" -PassThru -Wait

		Remove-Item -Path "$DownloadsFolder\jxl_winthumb.dll" -Force
	}
	catch {
		<#Do this if a terminating exception happens#>
	}
}

<#
	.SYNOPSIS
	Hidden files, folders, and drives

	.PARAMETER Enable
	Show hidden files, folders, and drives

	.PARAMETER Disable
	Do not show hidden files, folders, and drives

	.EXAMPLE
	HiddenItems -Enable

	.EXAMPLE
	HiddenItems -Disable

	.NOTES
	Current user
#>
function HiddenItems {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -PropertyType DWord -Value 1 -Force
		}
		"Disable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -PropertyType DWord -Value 2 -Force
		}
	}
}

<#
	.SYNOPSIS
	File name extensions

	.PARAMETER Show
	Show file name extensions

	.PARAMETER Hide
	Hide file name extensions

	.EXAMPLE
	FileExtensions -Show

	.EXAMPLE
	FileExtensions -Hide

	.NOTES
	Current user
#>
function FileExtensions {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Show" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -PropertyType DWord -Value 0 -Force
		}
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Classic Windows context menu

	.PARAMETER Disable
	Disable classic Windows context menu

	.PARAMETER Enable
	Enable classic Windows context menu

	.EXAMPLE
	ClassicContextMenu -Enable

	.EXAMPLE
	ClassicContextMenu -Disable

	.NOTES
	Current user
#>
function ClassicContextMenu {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			if (-not (Test-Path -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}")) {
				New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Name "InprocServer32" -Force -Value ""
			}
		}
		"Disable" {
			Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Recurse -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	Gallery in Windows explorer

	.PARAMETER Disable
	Hide gallery in Windows explorer

	.PARAMETER Enable
	Show gallery in Windows explorer

	.EXAMPLE
	Gallery -Hide

	.EXAMPLE
	Gallery -Show

	.NOTES
	Current user
#>
function Gallery {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			if (Test-Path -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}") {
				Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Recurse -Force -ErrorAction Ignore
			}
		}
		"Show" {
			New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327" -Name "{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Force -Value ""
		}
	}
}

<#
	.SYNOPSIS
	The file transfer dialog box mode

	.PARAMETER Detailed
	Show the file transfer dialog box in the detailed mode

	.PARAMETER Compact
	Show the file transfer dialog box in the compact mode

	.EXAMPLE
	FileTransferDialog -Detailed

	.EXAMPLE
	FileTransferDialog -Compact

	.NOTES
	Current user
#>
function FileTransferDialog {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Detailed"
		)]
		[switch]
		$Detailed,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Compact"
		)]
		[switch]
		$Compact
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Detailed" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -PropertyType DWord -Value 1 -Force
		}
		"Compact" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -PropertyType DWord -Value 0 -Force
		}
	}
}

<#
	.SYNOPSIS
	Recently used files in Quick access

	.PARAMETER Hide
	Hide recently used files in Quick access

	.PARAMETER Show
	Show recently used files in Quick access

	.EXAMPLE
	QuickAccessRecentFiles -Hide

	.EXAMPLE
	QuickAccessRecentFiles -Show

	.NOTES
	Current user
#>
function QuickAccessRecentFiles {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -PropertyType DWord -Value 0 -Force
		}
		"Show" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Frequently used folders in Quick access

	.PARAMETER Hide
	Hide frequently used folders in Quick access

	.PARAMETER Show
	Show frequently used folders in Quick access

	.EXAMPLE
	QuickAccessFrequentFolders -Hide

	.EXAMPLE
	QuickAccessFrequentFolders -Show

	.NOTES
	Current user
#>
function QuickAccessFrequentFolders {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -PropertyType DWord -Value 0 -Force
		}
		"Show" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Show Files from Office.com in File Explorer

	.PARAMETER Show
	Show Files from Office.com

	.PARAMETER Hide
	Do not show Files from Office.com

	.EXAMPLE
	ShowFilesOffice -Show

	.EXAMPLE
	ShowFilesOffice -Hide

	.NOTES
	Current user
#>
function ShowFilesOffice {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Show" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name ShowCloudFilesInQuickAccess -PropertyType DWord -Value 1 -Force
		}
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name ShowCloudFilesInQuickAccess -PropertyType DWord -Value 0 -Force
		}
	}
}

<#
	.SYNOPSIS
	The widgets icon on the taskbar

	.PARAMETER Hide
	Hide the widgets icon on the taskbar

	.PARAMETER Show
	Show the widgets icon on the taskbar

	.EXAMPLE
	TaskbarWidgets -Hide

	.EXAMPLE
	TaskbarWidgets -Show

	.NOTES
	Current user
#>
function TaskbarWidgets {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			if (Get-AppxPackage -Name MicrosoftWindows.Client.WebExperience) {
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -PropertyType DWord -Value 0 -Force
			}
		}
		"Show" {
			if (Get-AppxPackage -Name MicrosoftWindows.Client.WebExperience) {
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -PropertyType DWord -Value 1 -Force
			}
		}
	}
}

<#
	.SYNOPSIS
	Search on the taskbar

	.PARAMETER Hide
	Hide the search on the taskbar

	.PARAMETER SearchIcon
	Show the search icon on the taskbar

	.PARAMETER SearchBox
	Show the search box on the taskbar

	.EXAMPLE
	TaskbarSearch -Hide

	.EXAMPLE
	TaskbarSearch -SearchIcon

	.EXAMPLE
	TaskbarSearch -SearchIconLabel

	.EXAMPLE
	TaskbarSearch -SearchBox

	.NOTES
	Current user
#>
function TaskbarSearch {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "SearchIcon"
		)]
		[switch]
		$SearchIcon,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "SearchIconLabel"
		)]
		[switch]
		$SearchIconLabel,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "SearchBox"
		)]
		[switch]
		$SearchBox
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType DWord -Value 0 -Force
		}
		"SearchIcon" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType DWord -Value 1 -Force
		}
		"SearchIconLabel" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType DWord -Value 3 -Force
		}
		"SearchBox" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType DWord -Value 2 -Force
		}
	}
}

<#
	.SYNOPSIS
	Search highlights

	.PARAMETER Hide
	Hide search highlights

	.PARAMETER Show
	Show search highlights

	.EXAMPLE
	SearchHighlights -Hide

	.EXAMPLE
	SearchHighlights -Show

	.NOTES
	Current user
#>
function SearchHighlights {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			# Check whether "Ask Copilot" and "Find results in Web" (Web) were disabled. They also disable Search Highlights automatically
			# Due to "Set-StrictMode -Version Latest" we have to use GetValue()
			$BingSearchEnabled = ([Microsoft.Win32.Registry]::GetValue("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search", "BingSearchEnabled", $null))
			$DisableSearchBoxSuggestions = ([Microsoft.Win32.Registry]::GetValue("HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer", "DisableSearchBoxSuggestions", $null))
			if (($BingSearchEnabled -eq 1) -or ($DisableSearchBoxSuggestions -eq 1)) {
				Write-Information -MessageData "" -InformationAction Continue
				Write-Verbose -Message $Localization.Skipped -Verbose

				return
			}
			else {
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -PropertyType DWord -Value 0 -Force
			}
		}
		"Show" {
			# Enable "Ask Copilot" and "Find results in Web" (Web) icons in Windows Search in order to enable Search Highlights
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Force -ErrorAction Ignore
			Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Force -ErrorAction Ignore

			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Copilot button on the taskbar

	.PARAMETER Hide
	Hide Copilot button on the taskbar

	.PARAMETER Show
	Show Copilot button on the taskbar

	.EXAMPLE
	CopilotButton -Hide

	.EXAMPLE
	CopilotButton -Show

	.NOTES
	Current user
#>
function CopilotButton {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -PropertyType DWord -Value 0 -Force
		}
		"Show" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Task view button on the taskbar

	.PARAMETER Hide
	Hide the Task view button on the taskbar

	.PARAMETER Show
	Show the Task View button on the taskbar

	.EXAMPLE
	TaskViewButton -Hide

	.EXAMPLE
	TaskViewButton -Show

	.NOTES
	Current user
#>
function TaskViewButton {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -PropertyType DWord -Value 0 -Force
		}
		"Show" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Chat (Microsoft Teams) installation for new users

	.PARAMETER Enable
	Hide the Chat icon (Microsoft Teams) on the taskbar and prevent Microsoft Teams from installing for new users

	.PARAMETER Disable
	Show the Chat icon (Microsoft Teams) on the taskbar and remove block from installing Microsoft Teams for new users

	.EXAMPLE
	PreventTeamsInstallation -Enable

	.EXAMPLE
	PreventTeamsInstallation -Disable

	.NOTES
	Current user
#>
function PreventTeamsInstallation {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	Clear-Variable -Name Task -ErrorAction Ignore

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			# Save string to run it as "NT SERVICE\TrustedInstaller"
			# Prevent Microsoft Teams from installing for new users
			$Task = "New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications -Name ConfigureChatAutoInstall -Value 0 -Type Dword -Force"
		}
		"Enable" {
			# Save string to run it as "NT SERVICE\TrustedInstaller"
			# Remove block from installing Microsoft Teams for new users
			$Task = "Remove-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications -Name ConfigureChatAutoInstall -Value 1 -Type Dword -Force"
		}
	}

	# Create a Scheduled Task to run it as "NT SERVICE\TrustedInstaller"
	$Parameters = @{
		TaskName = "BlockTeamsInstallation"
		Action   = New-ScheduledTaskAction -Execute powershell.exe -Argument "-WindowStyle Hidden -Command $Task"
	}
	Register-ScheduledTask @Parameters -Force

	$ScheduleService = New-Object -ComObject Schedule.Service
	$ScheduleService.Connect()
	$ScheduleService.GetFolder("\").GetTask("BlockTeamsInstallation").RunEx($null, 0, 0, "NT SERVICE\TrustedInstaller")

	# Remove temporary task
	Unregister-ScheduledTask -TaskName BlockTeamsInstallation -Confirm:$false
}

<#
	.SYNOPSIS
	The Control Panel icons view

	.PARAMETER Category
	View the Control Panel icons by category

	.PARAMETER LargeIcons
	View the Control Panel icons by large icons

	.PARAMETER SmallIcons
	View the Control Panel icons by Small icons

	.EXAMPLE
	ControlPanelView -Category

	.EXAMPLE
	ControlPanelView -LargeIcons

	.EXAMPLE
	ControlPanelView -SmallIcons

	.NOTES
	Current user
#>
function ControlPanelView {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Category"
		)]
		[switch]
		$Category,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "LargeIcons"
		)]
		[switch]
		$LargeIcons,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "SmallIcons"
		)]
		[switch]
		$SmallIcons
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Category" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -PropertyType DWord -Value 0 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -PropertyType DWord -Value 0 -Force
		}
		"LargeIcons" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -PropertyType DWord -Value 0 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -PropertyType DWord -Value 1 -Force
		}
		"SmallIcons" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "AllItemsIconView" -PropertyType DWord -Value 1 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" -Name "StartupPage" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	The default Windows mode

	.PARAMETER Dark
	Set the default Windows mode to dark

	.PARAMETER Light
	Set the default Windows mode to light

	.EXAMPLE
	WindowsColorScheme -Dark

	.EXAMPLE
	WindowsColorScheme -Light

	.NOTES
	Current user
#>
function WindowsColorMode {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Dark"
		)]
		[switch]
		$Dark,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Light"
		)]
		[switch]
		$Light
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Dark" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -PropertyType DWord -Value 0 -Force
		}
		"Light" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	The default app mode

	.PARAMETER Dark
	Set the default app mode to dark

	.PARAMETER Light
	Set the default app mode to light

	.EXAMPLE
	AppColorMode -Dark

	.EXAMPLE
	AppColorMode -Light

	.NOTES
	Current user
#>
function AppColorMode {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Dark"
		)]
		[switch]
		$Dark,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Light"
		)]
		[switch]
		$Light
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Dark" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -PropertyType DWord -Value 0 -Force
		}
		"Light" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	First sign-in animation after the upgrade

	.PARAMETER Disable
	Disable first sign-in animation after the upgrade

	.PARAMETER Enable
	Enable first sign-in animation after the upgrade

	.EXAMPLE
	FirstLogonAnimation -Disable

	.EXAMPLE
	FirstLogonAnimation -Enable

	.NOTES
	Current user
#>
function FirstLogonAnimation {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "EnableFirstLogonAnimation" -PropertyType DWord -Value 0 -Force
		}
		"Enable" {
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "EnableFirstLogonAnimation" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	The quality factor of the JPEG desktop wallpapers

	.PARAMETER Max
	Set the quality factor of the JPEG desktop wallpapers to maximum

	.PARAMETER Default
	Set the quality factor of the JPEG desktop wallpapers to default

	.EXAMPLE
	JPEGWallpapersQuality -Max

	.EXAMPLE
	JPEGWallpapersQuality -Default

	.NOTES
	Current user
#>
function JPEGWallpapersQuality {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Max"
		)]
		[switch]
		$Max,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Max" {
			New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -PropertyType DWord -Value 100 -Force
		}
		"Default" {
			Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "JPEGImportQuality" -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	The "- Shortcut" suffix adding to the name of the created shortcuts

	.PARAMETER Disable
	Do not add the "- Shortcut" suffix to the file name of created shortcuts

	.PARAMETER Enable
	Add the "- Shortcut" suffix to the file name of created shortcuts

	.EXAMPLE
	ShortcutsSuffix -Disable

	.EXAMPLE
	ShortcutsSuffix -Enable

	.NOTES
	Current user
#>
function ShortcutsSuffix {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" -Name "ShortcutNameTemplate" -PropertyType String -Value "%s.lnk" -Force
		}
		"Enable" {
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" -Name "ShortcutNameTemplate" -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	The Print screen button usage

	.PARAMETER Enable
	Use the Print screen button to open screen snipping

	.PARAMETER Disable
	Do not use the Print screen button to open screen snipping

	.EXAMPLE
	PrtScnSnippingTool -Enable

	.EXAMPLE
	PrtScnSnippingTool -Disable

	.NOTES
	Current user
#>
function PrtScnSnippingTool {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "PrintScreenKeyForSnippingEnabled" -PropertyType DWord -Value 1 -Force
		}
		"Disable" {
			New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "PrintScreenKeyForSnippingEnabled" -PropertyType DWord -Value 0 -Force
		}
	}
}

<#
	.SYNOPSIS
	A different input method for each app window

	.PARAMETER Enable
	Let me use a different input method for each app window

	.PARAMETER Disable
	Do not use a different input method for each app window

	.EXAMPLE
	AppsLanguageSwitch -Enable

	.EXAMPLE
	AppsLanguageSwitch -Disable

	.NOTES
	Current user
#>
function AppsLanguageSwitch {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			Set-WinLanguageBarOption -UseLegacySwitchMode
		}
		"Disable" {
			Set-WinLanguageBarOption
		}
	}
}

<#
	.SYNOPSIS
	Title bar window shake

	.PARAMETER Enable
	When I grab a windows's title bar and shake it, minimize all other windows

	.PARAMETER Disable
	When I grab a windows's title bar and shake it, don't minimize all other windows

	.EXAMPLE
	AeroShaking -Enable

	.EXAMPLE
	AeroShaking -Disable

	.NOTES
	Current user
#>
function AeroShaking {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisallowShaking" -PropertyType DWord -Value 0 -Force
		}
		"Disable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisallowShaking" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Free "Windows 11 Cursors Concept v2" cursors from Jepri Creations

	.PARAMETER Dark
	Download and install free dark "Windows 11 Cursors Concept v2" cursors from Jepri Creations

	.PARAMETER Light
	Download and install free light "Windows 11 Cursors Concept v2" cursors from Jepri Creations

	.PARAMETER Default
	Set default cursors

	.EXAMPLE
	Cursors -Dark

	.EXAMPLE
	Cursors -Light

	.EXAMPLE
	Cursors -Default

	.LINK
	https://www.deviantart.com/jepricreations/art/Windows-11-Cursors-Concept-v2-886489356

	.NOTES
	The 21/05/23 version

	.NOTES
	Current user
#>
function Cursors {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Dark"
		)]
		[switch]
		$Dark,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Light"
		)]
		[switch]
		$Light,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Dark" {
			try {
				# Check the internet connection
				$Parameters = @{
					Name        = "dns.msftncsi.com"
					Server      = "1.1.1.1"
					DnsOnly     = $true
					ErrorAction = "Stop"
				}
				if ((Resolve-DnsName @Parameters).IPAddress -notcontains "131.107.255.255") {
					return
				}

				try {
					# Check whether https://github.com is alive
					$Parameters = @{
						Uri              = "https://github.com"
						Method           = "Head"
						DisableKeepAlive = $true
						UseBasicParsing  = $true
					}
					if (-not (Invoke-WebRequest @Parameters).StatusDescription) {
						Write-Information -MessageData "" -InformationAction Continue
						Write-Verbose -Message $Localization.Skipped -Verbose

						return
					}

					$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
					$Parameters = @{
						Uri             = "https://github.com/vadim1884321/dotfiles/raw/main/windows/Cursors/dark.zip"
						OutFile         = "$DownloadsFolder\dark.zip"
						UseBasicParsing = $true
						Verbose         = $true
					}
					Invoke-WebRequest @Parameters

					if (-not (Test-Path -Path "$env:SystemRoot\Cursors\W11_dark_v2.2")) {
						New-Item -Path "$env:SystemRoot\Cursors\W11_dark_v2.2" -ItemType Directory -Force
					}

					# Extract archive. We cannot call tar.exe due to it fails to extract files if username has cyrillic first letter in lowercase
					# Start-Process -FilePath "$env:SystemRoot\System32\tar.exe" -ArgumentList "-xf `"$DownloadsFolder\dark.zip`" -C `"$env:SystemRoot\Cursors\W11_dark_v2.2`" -v"
					# https://github.com/PowerShell/PowerShell/issues/21070
					Add-Type -Assembly System.IO.Compression.FileSystem
					$ZIP = [IO.Compression.ZipFile]::OpenRead("$DownloadsFolder\dark.zip")
					$ZIP.Entries | ForEach-Object -Process {
						[IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$env:SystemRoot\Cursors\W11_dark_v2.2\$($_.Name)", $true)
					}
					$ZIP.Dispose()

					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "(default)" -PropertyType String -Value "W11 Cursors Dark Free v2.2 by Jepri Creations" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name AppStarting -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\working.ani" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Arrow -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\pointer.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name ContactVisualization -PropertyType DWord -Value 1 -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Crosshair -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\precision.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name CursorBaseSize -PropertyType DWord -Value 32 -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name GestureVisualization -PropertyType DWord -Value 31 -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Hand -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\link.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Help -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\help.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name IBeam -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\beam.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name No -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\unavailable.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name NWPen -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\handwriting.cur" -Force
					# This is not a typo
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Person -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\pin.cur" -Force
					# This is not a typo
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Pin -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\person.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name precisionhair -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\precision.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Scheme Source" -PropertyType DWord -Value 1 -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeAll -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\move.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNESW -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\dgn2.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNS -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\vert.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNWSE -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\dgn1.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeWE -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\horz.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name UpArrow -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\alternate.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Wait -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_dark_v2.2\busy.ani" -Force

					if (-not (Test-Path -Path "HKCU:\Control Panel\Cursors\Schemes")) {
						New-Item -Path "HKCU:\Control Panel\Cursors\Schemes" -Force
					}
					[string[]]$Schemes = (
						"%SystemRoot%\Cursors\W11_dark_v2.2\pointer.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\help.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\working.ani",
						"%SystemRoot%\Cursors\W11_dark_v2.2\busy.ani",
						"%SystemRoot%\Cursors\W11_dark_v2.2\precision.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\beam.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\handwriting.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\unavailable.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\vert.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\horz.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\dgn1.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\dgn2.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\move.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\alternate.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\link.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\person.cur",
						"%SystemRoot%\Cursors\W11_dark_v2.2\pin.cur"
					) -join ","
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors\Schemes" -Name "W11 Cursors Dark Free v2.2 by Jepri Creations" -PropertyType String -Value $Schemes -Force

					Start-Sleep -Seconds 1

					Remove-Item -Path "$DownloadsFolder\dark.zip" -Force
				}
				catch [System.Net.WebException] {
					Write-Warning -Message ($Localization.NoResponse -f "https://github.com")
					Write-Error -Message ($Localization.NoResponse -f "https://github.com") -ErrorAction SilentlyContinue

					Write-Error -Message ($Localization.RestartFunction -f $MyInvocation.Line.Trim()) -ErrorAction SilentlyContinue
				}
			}
			catch [System.ComponentModel.Win32Exception] {
				Write-Warning -Message $Localization.NoInternetConnection
				Write-Error -Message $Localization.NoInternetConnection -ErrorAction SilentlyContinue

				Write-Error -Message ($Localization.RestartFunction -f $MyInvocation.Line.Trim()) -ErrorAction SilentlyContinue
			}
		}
		"Light" {
			try {
				# Check the internet connection
				$Parameters = @{
					Name        = "dns.msftncsi.com"
					Server      = "1.1.1.1"
					DnsOnly     = $true
					ErrorAction = "Stop"
				}
				if ((Resolve-DnsName @Parameters).IPAddress -notcontains "131.107.255.255") {
					return
				}

				try {
					# Check whether https://github.com is alive
					$Parameters = @{
						Uri              = "https://github.com"
						Method           = "Head"
						DisableKeepAlive = $true
						UseBasicParsing  = $true
					}
					if (-not (Invoke-WebRequest @Parameters).StatusDescription) {
						Write-Information -MessageData "" -InformationAction Continue
						Write-Verbose -Message $Localization.Skipped -Verbose

						return
					}

					$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
					$Parameters = @{
						Uri             = "https://github.com/vadim1884321/dotfiles/raw/main/windows/Cursors/light.zip"
						OutFile         = "$DownloadsFolder\light.zip"
						UseBasicParsing = $true
						Verbose         = $true
					}
					Invoke-WebRequest @Parameters

					if (-not (Test-Path -Path "$env:SystemRoot\Cursors\W11_light_v2.2")) {
						New-Item -Path "$env:SystemRoot\Cursors\W11_light_v2.2" -ItemType Directory -Force
					}

					# Extract archive. We cannot call tar.exe due to it fails to extract files if username has cyrillic first letter in lowercase
					# Start-Process -FilePath "$env:SystemRoot\System32\tar.exe" -ArgumentList "-xf `"$DownloadsFolder\light.zip`" -C `"$env:SystemRoot\Cursors\W11_dark_v2.2`" -v"
					# https://github.com/PowerShell/PowerShell/issues/21070
					Add-Type -Assembly System.IO.Compression.FileSystem
					$ZIP = [IO.Compression.ZipFile]::OpenRead("$DownloadsFolder\light.zip")
					$ZIP.Entries | ForEach-Object -Process {
						[IO.Compression.ZipFileExtensions]::ExtractToFile($_, "$env:SystemRoot\Cursors\W11_light_v2.2\$($_.Name)", $true)
					}
					$ZIP.Dispose()

					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "(default)" -PropertyType String -Value "W11 Cursor Light Free v2.2 by Jepri Creations" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name AppStarting -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\working.ani" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Arrow -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\pointer.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name ContactVisualization -PropertyType DWord -Value 1 -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Crosshair -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\precision.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name CursorBaseSize -PropertyType DWord -Value 32 -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name GestureVisualization -PropertyType DWord -Value 31 -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Hand -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\link.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Help -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\help.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name IBeam -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\beam.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name No -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\unavailable.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name NWPen -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\handwriting.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Person -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\person.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Pin -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\pin.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name precisionhair -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\precision.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Scheme Source" -PropertyType DWord -Value 1 -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeAll -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\move.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNESW -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\dgn2.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNS -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\vert.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNWSE -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\dgn1.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeWE -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\horz.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name UpArrow -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\alternate.cur" -Force
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Wait -PropertyType ExpandString -Value "%SystemRoot%\Cursors\W11_light_v2.2\busy.ani" -Force

					if (-not (Test-Path -Path "HKCU:\Control Panel\Cursors\Schemes")) {
						New-Item -Path "HKCU:\Control Panel\Cursors\Schemes" -Force
					}
					[string[]]$Schemes = (
						"%SystemRoot%\Cursors\W11_light_v2.2\pointer.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\help.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\working.ani",
						"%SystemRoot%\Cursors\W11_light_v2.2\busy.ani", ,
						"%SystemRoot%\Cursors\W11_light_v2.2\precision.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\beam.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\handwriting.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\unavailable.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\vert.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\horz.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\dgn1.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\dgn2.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\move.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\alternate.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\link.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\person.cur",
						"%SystemRoot%\Cursors\W11_light_v2.2\pin.cur"
					) -join ","
					New-ItemProperty -Path "HKCU:\Control Panel\Cursors\Schemes" -Name "W11 Cursor Light Free v2.2 by Jepri Creations" -PropertyType String -Value $Schemes -Force

					Start-Sleep -Seconds 1

					Remove-Item -Path "$DownloadsFolder\light.zip" -Force
				}
				catch [System.Net.WebException] {
					Write-Warning -Message ($Localization.NoResponse -f "https://github.com")
					Write-Error -Message ($Localization.NoResponse -f "https://github.com") -ErrorAction SilentlyContinue

					Write-Error -Message ($Localization.RestartFunction -f $MyInvocation.Line.Trim()) -ErrorAction SilentlyContinue
				}
			}
			catch [System.ComponentModel.Win32Exception] {
				Write-Warning -Message $Localization.NoInternetConnection
				Write-Error -Message $Localization.NoInternetConnection -ErrorAction SilentlyContinue

				Write-Error -Message ($Localization.RestartFunction -f $MyInvocation.Line.Trim()) -ErrorAction SilentlyContinue
			}
		}
		"Default" {
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "(default)" -PropertyType String -Value "" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name AppStarting -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_working.ani" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Arrow -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_arrow.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name ContactVisualization -PropertyType DWord -Value 1 -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Crosshair -PropertyType ExpandString -Value "" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name CursorBaseSize -PropertyType DWord -Value 32 -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name GestureVisualization -PropertyType DWord -Value 31 -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Hand -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_link.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Help -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_helpsel.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name IBeam -PropertyType ExpandString -Value "" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name No -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_unavail.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name NWPen -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_pen.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Person -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_person.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Pin -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_pin.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "Scheme Source" -PropertyType DWord -Value 2 -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeAll -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_move.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNESW -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_nesw.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNS -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_ns.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeNWSE -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_nwse.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name SizeWE -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_ew.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name UpArrow -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_up.cur" -Force
			New-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name Wait -PropertyType ExpandString -Value "%SystemRoot%\cursors\aero_up.cur" -Force
		}
	}
}

<#
	.SYNOPSIS
	Files and folders grouping in the Downloads folder

	.PARAMETER None
	Do not group files and folder in the Downloads folder

	.PARAMETER Default
	Group files and folder by date modified in the Downloads folder (default value)

	.EXAMPLE
	FolderGroupBy -None

	.EXAMPLE
	FolderGroupBy -Default

	.NOTES
	Current user
#>
function FolderGroupBy {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "None"
		)]
		[switch]
		$None,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default
	)

	switch ($PSCmdlet.ParameterSetName) {
		"None" {
			# Clear any Common Dialog views
			Get-ChildItem -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\*\Shell" -Recurse | Where-Object -FilterScript { $_.PSChildName -eq "{885A186E-A440-4ADA-812B-DB871B942259}" } | Remove-Item -Force

			# https://learn.microsoft.com/en-us/windows/win32/properties/props-system-null
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name ColumnList -PropertyType String -Value "System.Null" -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name GroupBy -PropertyType String -Value "System.Null" -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name LogicalViewMode -PropertyType DWord -Value 1 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name Name -PropertyType String -Value NoName -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name Order -PropertyType DWord -Value 0 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name PrimaryProperty -PropertyType String -Value "System.ItemNameDisplay" -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}\TopViews\{00000000-0000-0000-0000-000000000000}" -Name SortByList -PropertyType String -Value "prop:System.ItemNameDisplay" -Force
		}
		"Default" {
			Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{885a186e-a440-4ada-812b-db871b942259}" -Recurse -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	Storage Sense

	.PARAMETER Enable
	Turn on Storage Sense

	.PARAMETER Disable
	Turn off Storage Sense

	.EXAMPLE
	StorageSense -Enable

	.EXAMPLE
	StorageSense -Disable

	.NOTES
	Current user
#>
function StorageSense {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -ItemType Directory -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01 -PropertyType DWord -Value 1 -Force
		}
		"Disable" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -ItemType Directory -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01 -PropertyType DWord -Value 0 -Force
		}
	}
}

<#
	.SYNOPSIS
	Storage Sense running frequency

	.PARAMETER Month
	Run Storage Sense every month

	.PARAMETER Default
	Run Storage Sense during low free disk space

	.EXAMPLE
	StorageSenseFrequency -Month

	.EXAMPLE
	StorageSenseFrequency -Default

	.NOTES
	Current user
#>
function StorageSenseFrequency {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Month"
		)]
		[switch]
		$Month,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Month" {
			if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01) -eq "1") {
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 2048 -PropertyType DWord -Value 30 -Force
			}
		}
		"Default" {
			if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01) -eq "1") {
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 2048 -PropertyType DWord -Value 0 -Force
			}
		}
	}
}

<#
	.SYNOPSIS
	Clean up of temporary files

	.PARAMETER Enable
	Turn on automatic cleaning up temporary system and app files

	.PARAMETER Disable
	Turn off automatic cleaning up temporary system and app files

	.EXAMPLE
	StorageSenseTempFiles -Enable

	.EXAMPLE
	StorageSenseTempFiles -Disable

	.NOTES
	Current user
#>
function StorageSenseTempFiles {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01) -eq "1") {
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 04 -PropertyType DWord -Value 1 -Force
			}
		}
		"Disable" {
			if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01) -eq "1") {
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 04 -PropertyType DWord -Value 0 -Force
			}
		}
	}
}

<#
	.SYNOPSIS
	Stop error code when BSoD occurs

	.PARAMETER Enable
	Display Stop error code when BSoD occurs

	.PARAMETER Disable
	Do not display stop error code when BSoD occurs

	.EXAMPLE
	BSoDStopError -Enable

	.EXAMPLE
	BSoDStopError -Disable

	.NOTES
	Machine-wide
#>
function BSoDStopError {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "DisplayParameters" -PropertyType DWord -Value 1 -Force
		}
		"Disable" {
			New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "DisplayParameters" -PropertyType DWord -Value 0 -Force
		}
	}
}

<#
	.SYNOPSIS
	The User Account Control (UAC) behavior

	.PARAMETER Never
	Never notify

	.PARAMETER Default
	Notify me only when apps try to make changes to my computer

	.EXAMPLE
	AdminApprovalMode -Never

	.EXAMPLE
	AdminApprovalMode -Default

	.NOTES
	Machine-wide
#>
function AdminApprovalMode {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Never"
		)]
		[switch]
		$Never,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Never" {
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -PropertyType DWord -Value 0 -Force
		}
		"Default" {
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -PropertyType DWord -Value 5 -Force
		}
	}
}

<#
	.SYNOPSIS
	Access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled

	.PARAMETER Enable
	Turn on access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled

	.PARAMETER Disable
	Turn off access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled

	.EXAMPLE
	MappedDrivesAppElevatedAccess -Enable

	.EXAMPLE
	MappedDrivesAppElevatedAccess -Disable

	.NOTES
	Machine-wide
#>
function MappedDrivesAppElevatedAccess {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -PropertyType DWord -Value 1 -Force
		}
		"Disable" {
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	Delivery Optimization

	.PARAMETER Disable
	Turn off Delivery Optimization

	.PARAMETER Enable
	Turn on Delivery Optimization

	.EXAMPLE
	DeliveryOptimization -Disable

	.EXAMPLE
	DeliveryOptimization -Enable

	.NOTES
	Current user
#>
function DeliveryOptimization {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			New-ItemProperty -Path Registry::HKEY_USERS\S-1-5-20\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings -Name DownloadMode -PropertyType DWord -Value 0 -Force
			Delete-DeliveryOptimizationCache -Force
		}
		"Enable" {
			New-ItemProperty -Path Registry::HKEY_USERS\S-1-5-20\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings -Name DownloadMode -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Receive updates for other Microsoft products

	.PARAMETER Enable
	Receive updates for other Microsoft products

	.PARAMETER Disable
	Do not receive updates for other Microsoft products

	.EXAMPLE
	UpdateMicrosoftProducts -Enable

	.EXAMPLE
	UpdateMicrosoftProducts -Disable

	.NOTES
	Current user
#>
function UpdateMicrosoftProducts {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			(New-Object -ComObject Microsoft.Update.ServiceManager).AddService2("7971f918-a847-4430-9279-4a52d1efe18d", 7, "")
		}
		"Disable" {
			if (((New-Object -ComObject Microsoft.Update.ServiceManager).Services | Where-Object -FilterScript { $_.ServiceID -eq "7971f918-a847-4430-9279-4a52d1efe18d" }).IsDefaultAUService) {
				(New-Object -ComObject Microsoft.Update.ServiceManager).RemoveService("7971f918-a847-4430-9279-4a52d1efe18d")
			}
		}
	}
}

<#
	.SYNOPSIS
	Windows latest updates

	.PARAMETER Disable
	Do not get the latest updates as soon as they're available

	.PARAMETER Enable
	Get the latest updates as soon as they're available

	.EXAMPLE
	WindowsLatestUpdate -Disable

	.EXAMPLE
	WindowsLatestUpdate -Enable

	.NOTES
	Machine-wide
#>
function WindowsLatestUpdate {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "IsContinuousInnovationOptedIn" -PropertyType DWord -Value 0 -Force
		}
		"Enable" {
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "IsContinuousInnovationOptedIn" -PropertyType DWord -Value 1 -Force
		}
	}
}

<#
	.SYNOPSIS
	Power plan

	.PARAMETER High
	Set power plan on "High performance"

	.PARAMETER Balanced
	Set power plan on "Balanced"

	.EXAMPLE
	PowerPlan -High

	.EXAMPLE
	PowerPlan -Balanced

	.NOTES
	It isn't recommended to turn on for laptops

	.NOTES
	Current user
#>
function PowerPlan {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "High"
		)]
		[switch]
		$High,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Balanced"
		)]
		[switch]
		$Balanced
	)

	switch ($PSCmdlet.ParameterSetName) {
		"High" {
			# Set High performance profile
			powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
		}
		"Balanced" {
			# Set Balanced profile
			powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
		}
	}
}

<#
	.SYNOPSIS
	Hibernation

	.PARAMETER Disable
	Disable hibernation

	.PARAMETER Enable
	Enable hibernation

	.EXAMPLE
	Hibernation -Enable

	.EXAMPLE
	Hibernation -Disable

	.NOTES
	It isn't recommended to turn off for laptops

	.NOTES
	Current user
#>
function Hibernation {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			# Disable hibernate
			powercfg /hibernate off
		}
		"Enable" {
			# Enable hibernate
			powercfg /hibernate on
		}
	}
}

<#
	.SYNOPSIS
	Num Lock at startup

	.PARAMETER Enable
	Enable Num Lock at startup

	.PARAMETER Disable
	Disable Num Lock at startup

	.EXAMPLE
	NumLock -Enable

	.EXAMPLE
	NumLock -Disable

	.NOTES
	Current user
#>
function NumLock {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			New-ItemProperty -Path "Registry::HKEY_USERS\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -PropertyType String -Value 2147483650 -Force
		}
		"Disable" {
			New-ItemProperty -Path "Registry::HKEY_USERS\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -PropertyType String -Value 2147483648 -Force
		}
	}
}

<#
	.SYNOPSIS
	The shortcut to start Sticky Keys

	.PARAMETER Disable
	Turn off Sticky keys by pressing the Shift key 5 times

	.PARAMETER Enable
	Turn on Sticky keys by pressing the Shift key 5 times

	.EXAMPLE
	StickyShift -Disable

	.EXAMPLE
	StickyShift -Enable

	.NOTES
	Current user
#>
function StickyShift {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name Flags -PropertyType String -Value 506 -Force
		}
		"Enable" {
			New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name Flags -PropertyType String -Value 510 -Force
		}
	}
}

<#
	.SYNOPSIS
	AutoPlay for all media and devices

	.PARAMETER Disable
	Don't use AutoPlay for all media and devices

	.PARAMETER Enable
	Use AutoPlay for all media and devices

	.EXAMPLE
	Autoplay -Disable

	.EXAMPLE
	Autoplay -Enable

	.NOTES
	Current user
#>
function Autoplay {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -PropertyType DWord -Value 1 -Force
		}
		"Enable" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -PropertyType DWord -Value 0 -Force
		}
	}
}

<#
	.SYNOPSIS
	Network Discovery File and Printers Sharing

	.PARAMETER Enable
	Enable "Network Discovery" and "File and Printers Sharing" for workgroup networks

	.PARAMETER Disable
	Disable "Network Discovery" and "File and Printers Sharing" for workgroup networks

	.EXAMPLE
	NetworkDiscovery -Enable

	.EXAMPLE
	NetworkDiscovery -Disable

	.NOTES
	Current user
#>
function NetworkDiscovery {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	$FirewallRules = @(
		# File and printer sharing
		"@FirewallAPI.dll,-32752",

		# Network discovery
		"@FirewallAPI.dll,-28502"
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			Set-NetFirewallRule -Group $FirewallRules -Profile Private -Enabled True
			Set-NetFirewallRule -Profile Public, Private -Name FPS-SMB-In-TCP -Enabled True
			Set-NetConnectionProfile -NetworkCategory Private
		}
		"Disable" {
			Set-NetFirewallRule -Group $FirewallRules -Profile Private -Enabled False
		}
	}
}

<#
	.SYNOPSIS
	Default terminal app

	.PARAMETER WindowsTerminal
	Set Windows Terminal as default terminal app to host the user interface for command-line applications

	.PARAMETER ConsoleHost
	Set Windows Console Host as default terminal app to host the user interface for command-line applications

	.EXAMPLE
	DefaultTerminalApp -WindowsTerminal

	.EXAMPLE
	DefaultTerminalApp -ConsoleHost

	.NOTES
	Current user
#>
function DefaultTerminalApp {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "WindowsTerminal"
		)]
		[switch]
		$WindowsTerminal,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "ConsoleHost"
		)]
		[switch]
		$ConsoleHost
	)

	switch ($PSCmdlet.ParameterSetName) {
		"WindowsTerminal" {
			if (Get-AppxPackage -Name Microsoft.WindowsTerminal) {
				# Checking if the Terminal version supports such feature
				$TerminalVersion = (Get-AppxPackage -Name Microsoft.WindowsTerminal).Version
				if ([System.Version]$TerminalVersion -ge [System.Version]"1.11") {
					if (-not (Test-Path -Path "HKCU:\Console\%%Startup")) {
						New-Item -Path "HKCU:\Console\%%Startup" -Force
					}

					# Find the current GUID of Windows Terminal
					$PackageFullName = (Get-AppxPackage -Name Microsoft.WindowsTerminal).PackageFullName
					Get-ChildItem -Path "HKLM:\SOFTWARE\Classes\PackagedCom\Package\$PackageFullName\Class" | ForEach-Object -Process {
						if ((Get-ItemPropertyValue -Path $_.PSPath -Name ServerId) -eq 0) {
							New-ItemProperty -Path "HKCU:\Console\%%Startup" -Name "DelegationConsole" -PropertyType String -Value $_.PSChildName -Force
						}

						if ((Get-ItemPropertyValue -Path $_.PSPath -Name ServerId) -eq 1) {
							New-ItemProperty -Path "HKCU:\Console\%%Startup" -Name "DelegationTerminal" -PropertyType String -Value $_.PSChildName -Force
						}
					}
				}
			}
		}
		"ConsoleHost" {
			New-ItemProperty -Path "HKCU:\Console\%%Startup" -Name "DelegationConsole" -PropertyType String -Value "{00000000-0000-0000-0000-000000000000}" -Force
			New-ItemProperty -Path "HKCU:\Console\%%Startup" -Name "DelegationTerminal" -PropertyType String -Value "{00000000-0000-0000-0000-000000000000}" -Force
		}
	}
}

<#
	.SYNOPSIS
	Bypass RKN restrictins using antizapret.prostovpn.org proxies

	.PARAMETER Enable
	Enable proxying only blocked sites from the unified registry of Roskomnadzor using antizapret.prostovpn.org servers

	.PARAMETER Disable
	Disable proxying only blocked sites from the unified registry of Roskomnadzor using antizapret.prostovpn.org servers

	.EXAMPLE
	RKNBypass -Enable

	.EXAMPLE
	RKNBypass -Disable

	.LINK
	https://antizapret.prostovpn.org

	.NOTES
	Current user
#>
function RKNBypass {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			# If current region is Russia
			if (((Get-WinHomeLocation).GeoId -eq "203")) {
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "AutoConfigURL" -PropertyType String -Value "https://p.thenewone.lol:8443/proxy.pac" -Force
			}
		}
		"Disable" {
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "AutoConfigURL" -Force -ErrorAction Ignore
		}
	}
}

<#
	.SYNOPSIS
	Configure Start layout

	.PARAMETER Default
	Show default Start layout

	.PARAMETER ShowMorePins
	Show more pins on Start

	.PARAMETER ShowMoreRecommendations
	Show more recommendations on Start

	.EXAMPLE
	StartLayout -Default

	.EXAMPLE
	StartLayout -ShowMorePins

	.EXAMPLE
	StartLayout -ShowMoreRecommendations

	.NOTES
	Current user
#>
function StartLayout {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "ShowMorePins"
		)]
		[switch]
		$ShowMorePins,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "ShowMoreRecommendations"
		)]
		[switch]
		$ShowMoreRecommendations
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Default" {
			# Default
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -PropertyType DWord -Value 0 -Force
		}
		"ShowMorePins" {
			# Show More Pins
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -PropertyType DWord -Value 1 -Force
		}
		"ShowMoreRecommendations" {
			# Show More Recommendations
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -PropertyType DWord -Value 2 -Force
		}
	}
}

<#
	.SYNOPSIS
	Microsoft Teams autostarting

	.PARAMETER Disable
	Enable Teams autostarting

	.PARAMETER Enable
	Disable Teams autostarting

	.EXAMPLE
	TeamsAutostart -Disable

	.EXAMPLE
	TeamsAutostart -Enable

	.NOTES
	Current user
#>
function TeamsAutostart {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	if (Get-AppxPackage -Name MicrosoftTeams) {
		switch ($PSCmdlet.ParameterSetName) {
			"Disable" {
				if (-not (Test-Path -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MicrosoftTeams_8wekyb3d8bbwe\TeamsStartupTask")) {
					New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MicrosoftTeams_8wekyb3d8bbwe\TeamsStartupTask" -Force
				}
				New-ItemProperty -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MicrosoftTeams_8wekyb3d8bbwe\TeamsStartupTask" -Name State -PropertyType DWord -Value 1 -Force
			}
			"Enable" {
				if (-not (Test-Path -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MicrosoftTeams_8wekyb3d8bbwe\TeamsStartupTask")) {
					New-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MicrosoftTeams_8wekyb3d8bbwe\TeamsStartupTask" -Force
				}
				New-ItemProperty -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\MicrosoftTeams_8wekyb3d8bbwe\TeamsStartupTask" -Name State -PropertyType DWord -Value 2 -Force
			}
		}
	}
}

# Dismiss Microsoft Defender offer in the Windows Security about signing in Microsoft account
function DismissMSAccount {
	if ($Script:DefenderEnabled) {
		New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -PropertyType DWord -Value 1 -Force
	}
}

# Dismiss Microsoft Defender offer in the Windows Security about turning on the SmartScreen filter for Microsoft Edge
function DismissSmartScreenFilter {
	if ($Script:DefenderEnabled) {
		New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AppAndBrowser_EdgeSmartScreenOff" -PropertyType DWord -Value 0 -Force
	}
}

<#
	.SYNOPSIS
	Logging for all Windows PowerShell modules

	.PARAMETER Enable
	Enable logging for all Windows PowerShell modules

	.PARAMETER Disable
	Disable logging for all Windows PowerShell modules

	.EXAMPLE
	PowerShellModulesLogging -Enable

	.EXAMPLE
	PowerShellModulesLogging -Disable

	.NOTES
	Machine-wide
#>
function PowerShellModulesLogging {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			if (-not (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames")) {
				New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" -Force
			}
			New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "EnableModuleLogging" -PropertyType DWord -Value 1 -Force
			New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" -Name * -PropertyType String -Value * -Force

			Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "EnableModuleLogging" -Type DWORD -Value 1
			Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" -Name * -Type SZ -Value *
		}
		"Disable" {
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "EnableModuleLogging" -Force -ErrorAction Ignore
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" -Name * -Force -ErrorAction Ignore

			Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "EnableModuleLogging" -Type CLEAR
		}
	}
}

<#
	.SYNOPSIS
	Logging for all PowerShell scripts input to the Windows PowerShell event log

	.PARAMETER Enable
	Enable logging for all PowerShell scripts input to the Windows PowerShell event log

	.PARAMETER Disable
	Disable logging for all PowerShell scripts input to the Windows PowerShell event log

	.EXAMPLE
	PowerShellScriptsLogging -Enable

	.EXAMPLE
	PowerShellScriptsLogging -Disable

	.NOTES
	Machine-wide
#>
function PowerShellScriptsLogging {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			if (-not (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging")) {
				New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Force
			}
			New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -PropertyType DWord -Value 1 -Force

			Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -Type DWORD -Value 1
		}
		"Disable" {
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -Force -ErrorAction Ignore
			Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -Type CLEAR
		}
	}
}

<#
	.SYNOPSIS
	Microsoft Defender SmartScreen

	.PARAMETER Disable
	Disable apps and files checking within Microsoft Defender SmartScreen

	.PARAMETER Enable
	Enable apps and files checking within Microsoft Defender SmartScreen

	.EXAMPLE
	AppsSmartScreen -Disable

	.EXAMPLE
	AppsSmartScreen -Enable

	.NOTES
	Machine-wide
#>
function AppsSmartScreen {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	if ($Script:DefenderEnabled) {
		switch ($PSCmdlet.ParameterSetName) {
			"Disable" {
				New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -PropertyType String -Value Off -Force
			}
			"Enable" {
				New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "SmartScreenEnabled" -PropertyType String -Value Warn -Force
			}
		}
	}
}

<#
	.SYNOPSIS
	The Attachment Manager

	.PARAMETER Disable
	Microsoft Defender SmartScreen doesn't marks downloaded files from the Internet as unsafe

	.PARAMETER Enable
	Microsoft Defender SmartScreen marks downloaded files from the Internet as unsafe

	.EXAMPLE
	SaveZoneInformation -Disable

	.EXAMPLE
	SaveZoneInformation -Enable

	.NOTES
	Current user
#>
function SaveZoneInformation {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Disable" {
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments")) {
				New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -PropertyType DWord -Value 1 -Force

			Set-Policy -Scope User -Path "Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Type DWORD -Value 1
		}
		"Enable" {
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Force -ErrorAction Ignore
			Set-Policy -Scope User -Path "Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Type CLEAR
		}
	}
}

<#
	.SYNOPSIS
	DNS-over-HTTPS for IPv4

	.PARAMETER Enable
	Enable DNS-over-HTTPS for IPv4

	.PARAMETER Disable
	Disable DNS-over-HTTPS for IPv4

	.EXAMPLE
	DNSoverHTTPS -Enable -PrimaryDNS 1.0.0.1 -SecondaryDNS 1.1.1.1

	.EXAMPLE Enable DNS-over-HTTPS via Comss.one DNS server. Applicable for Russia only
	DNSoverHTTPS -ComssOneDNS

	.EXAMPLE
	DNSoverHTTPS -Disable

	.NOTES
	The valid IPv4 addresses: 1.1.1.1, 1.0.0.1, 149.112.112.112, 8.8.4.4, 8.8.8.8, 9.9.9.9

	.LINK
	https://docs.microsoft.com/en-us/windows-server/networking/dns/doh-client-support

	.LINK
	https://www.comss.ru/page.php?id=7315

	.NOTES
	Machine-wide
#>
function DNSoverHTTPS {
	[CmdletBinding()]
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(Mandatory = $false)]
		[ValidateSet("1.0.0.1", "1.1.1.1", "149.112.112.112", "8.8.4.4", "8.8.8.8", "9.9.9.9")]
		# Isolate the IPv4 addresses only
		[ValidateScript({
			(@((Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\DohWellKnownServers).PSChildName) | Where-Object { $_ -notmatch ":" }) -contains $_
			})]
		[string]
		$PrimaryDNS,

		[Parameter(Mandatory = $false)]
		[ValidateSet("1.0.0.1", "1.1.1.1", "149.112.112.112", "8.8.4.4", "8.8.8.8", "9.9.9.9")]
		# Isolate the IPv4 addresses only
		[ValidateScript({
			(@((Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters\DohWellKnownServers).PSChildName) | Where-Object { $_ -notmatch ":" }) -contains $_
			})]
		[string]
		$SecondaryDNS,

		# https://www.comss.ru/page.php?id=7315
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "ComssOneDNS"
		)]
		[switch]
		$ComssOneDNS,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	# Determining whether Hyper-V is enabled
	# After enabling Hyper-V feature a virtual switch breing created, so we need to use different method to isolate the proper adapter
	if (-not (Get-CimInstance -ClassName CIM_ComputerSystem).HypervisorPresent) {
		$InterfaceGuids = @((Get-NetAdapter -Physical).InterfaceGuid)
	}
	else {
		$InterfaceGuids = @((Get-NetRoute -AddressFamily IPv4 | Where-Object -FilterScript { $_.DestinationPrefix -eq "0.0.0.0/0" } | Get-NetAdapter).InterfaceGuid)
	}

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			# Set a primary and secondary DNS servers
			if (-not (Get-CimInstance -ClassName CIM_ComputerSystem).HypervisorPresent) {
				Get-NetAdapter -Physical | Get-NetIPInterface -AddressFamily IPv4 | Set-DnsClientServerAddress -ServerAddresses $PrimaryDNS, $SecondaryDNS
			}
			else {
				Get-NetRoute | Where-Object -FilterScript { $_.DestinationPrefix -eq "0.0.0.0/0" } | Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses $PrimaryDNS, $SecondaryDNS
			}

			foreach ($InterfaceGuid in $InterfaceGuids) {
				if (-not (Test-Path -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\$PrimaryDNS")) {
					New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\$PrimaryDNS" -Force
				}
				if (-not (Test-Path -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\$SecondaryDNS")) {
					New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\$SecondaryDNS" -Force
				}
				# Encrypted preffered, unencrypted allowed
				New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\$PrimaryDNS" -Name DohFlags -PropertyType QWord -Value 5 -Force
				New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\$SecondaryDNS" -Name DohFlags -PropertyType QWord -Value 5 -Force
			}
		}
		"ComssOneDNS" {
			switch ((Get-WinHomeLocation).GeoId) {
				{ ($_ -ne 203) -and ($_ -ne 29) } {
					Write-Information -MessageData "" -InformationAction Continue
					Write-Verbose -Message $Localization.Skipped -Verbose

					return
				}
			}

			# Set a primary and secondary DNS servers
			if (-not (Get-CimInstance -ClassName CIM_ComputerSystem).HypervisorPresent) {
				Get-NetAdapter -Physical | Get-NetIPInterface -AddressFamily IPv4 | Set-DnsClientServerAddress -ServerAddresses 76.76.2.22
			}
			else {
				Get-NetRoute | Where-Object -FilterScript { $_.DestinationPrefix -eq "0.0.0.0/0" } | Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses 76.76.2.22
			}

			foreach ($InterfaceGuid in $InterfaceGuids) {
				if (-not (Test-Path -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\76.76.2.22")) {
					New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\76.76.2.22" -Force
				}
				New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\76.76.2.22" -Name DohFlags -PropertyType QWord -Value 2 -Force
				New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh\76.76.2.22" -Name DohTemplate -PropertyType String -Value https://dns.controld.com/comss -Force
			}
		}
		"Disable" {
			# Determining whether Hyper-V is enabled
			if (-not (Get-CimInstance -ClassName CIM_ComputerSystem).HypervisorPresent) {
				# Configure DNS servers automatically
				Get-NetAdapter -Physical | Get-NetIPInterface -AddressFamily IPv4 | Set-DnsClientServerAddress -ResetServerAddresses
			}
			else {
				# Configure DNS servers automatically
				Get-NetRoute | Where-Object -FilterScript { $_.DestinationPrefix -eq "0.0.0.0/0" } | Get-NetAdapter | Set-DnsClientServerAddress -ResetServerAddresses
			}

			foreach ($InterfaceGuid in $InterfaceGuids) {
				Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\InterfaceSpecificParameters\$InterfaceGuid\DohInterfaceSettings\Doh" -Recurse -Force -ErrorAction Ignore
			}
		}
	}

	Clear-DnsClientCache
	Register-DnsClient
}

<#
	.SYNOPSIS
	The "Open in Windows Terminal" item in the folders context menu

	.PARAMETER Hide
	Hide the "Open in Windows Terminal" item in the folders context menu

	.PARAMETER Show
	Show the "Open in Windows Terminal" item in the folders context menu

	.EXAMPLE
	OpenWindowsTerminalContext -Show

	.EXAMPLE
	OpenWindowsTerminalContext -Hide

	.NOTES
	Current user
#>
function OpenWindowsTerminalContext {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide
	)

	if (-not (Get-AppxPackage -Name Microsoft.WindowsTerminal)) {
		return
	}

	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -Force -ErrorAction Ignore

	switch ($PSCmdlet.ParameterSetName) {
		"Show" {
			Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -Force -ErrorAction Ignore
		}
		"Hide" {
			if (-not (Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked")) {
				New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Force
			}
			New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -PropertyType String -Value "" -Force
		}
	}
}

<#
	.SYNOPSIS
	Open Windows Terminal in context menu as administrator

	.PARAMETER Enable
	Open Windows Terminal in context menu as administrator by default

	.PARAMETER Disable
	Do not open Windows Terminal in context menu as administrator by default

	.EXAMPLE
	OpenWindowsTerminalAdminContext -Enable

	.EXAMPLE
	OpenWindowsTerminalAdminContext -Disable

	.NOTES
	Current user
#>
function OpenWindowsTerminalAdminContext {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	if (-not (Get-AppxPackage -Name Microsoft.WindowsTerminal)) {
		return
	}

	if (-not (Test-Path -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json")) {
		Start-Process -FilePath wt -PassThru
		Start-Sleep -Seconds 2
		Stop-Process -Name WindowsTerminal -Force -PassThru
	}

	try {
		$Terminal = Get-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Encoding UTF8 -Force | ConvertFrom-Json
	}
	catch [System.ArgumentException] {
		Write-Error -Message ($Global:Error.Exception.Message | Select-Object -First 1) -ErrorAction SilentlyContinue

		Invoke-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

		Write-Information -MessageData "" -InformationAction Continue
		Write-Verbose -Message $Localization.Skipped -Verbose

		return
	}

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -ErrorAction Ignore
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -ErrorAction Ignore

			if ($Terminal.profiles.defaults.elevate) {
				$Terminal.profiles.defaults.elevate = $true
			}
			else {
				$Terminal.profiles.defaults | Add-Member -MemberType NoteProperty -Name elevate -Value $true -Force
			}
		}
		"Disable" {
			if ($Terminal.profiles.defaults.elevate) {
				$Terminal.profiles.defaults.elevate = $false
			}
			else {
				$Terminal.profiles.defaults | Add-Member -MemberType NoteProperty -Name elevate -Value $false -Force
			}
		}
	}

	# Save in UTF-8 with BOM despite JSON must not has the BOM: https://datatracker.ietf.org/doc/html/rfc8259#section-8.1. Unless Terminal profile names which contains non-Latin characters will have "?" instead of titles
	ConvertTo-Json -InputObject $Terminal -Depth 4 | Set-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Encoding UTF8 -Force
}
