# Dismiss Microsoft Defender offer in the Windows Security about turning on the SmartScreen filter for Microsoft Edge
function DismissSmartScreenFilter
{
	if ($Script:DefenderEnabled)
	{
		New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows Security Health\State" -Name "AppAndBrowser_EdgeSmartScreenOff" -PropertyType DWord -Value 0 -Force
	}
}
