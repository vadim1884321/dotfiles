# PowerShell 7 doesn't load en-us localization automatically if there is no localization folder in user's language which is determined by $PSUICulture
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-localizeddata?view=powershell-7.3
# https://github.com/PowerShell/PowerShell/pull/19896
try
{
	Import-LocalizedData -BindingVariable Global:Localization -UICulture $PSUICulture -BaseDirectory $PSScriptRoot\..\..\Localizations -FileName Localizations -ErrorAction Stop
}
catch
{
	Import-LocalizedData -BindingVariable Global:Localization -UICulture en-US -BaseDirectory $PSScriptRoot\..\..\Localizations -FileName Localizations
}
