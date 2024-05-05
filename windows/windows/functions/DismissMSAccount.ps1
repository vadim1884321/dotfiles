# Dismiss Microsoft Defender offer in the Windows Security about signing in Microsoft account
function DismissMSAccount
{
	if ($Script:DefenderEnabled)
	{
		New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AccountProtection_MicrosoftAccount_Disconnected" -PropertyType DWord -Value 1 -Force
	}
}
