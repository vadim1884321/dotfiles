<#
.SYNOPSIS
Configures Microsoft Edge using group policies.

.DESCRIPTION
The script configures Microsoft Edge by creating group policy settings in the registry.
You can set the policies for all users or for the current user only.

.PARAMETER scope
Accepts HKLM (all users) or HKCU (current user, default behavior).

.EXAMPLE
PS> .\edge-policy.ps1
Applies the policy to the current user only.

.EXAMPLE
PS> .\context-menu.ps1 -scope HKLM
Applies the policy to all users.

.LINK
Blog: https://www.outsidethebox.ms/22326
Documentation: https://learn.microsoft.com/en-us/DeployEdge/microsoft-edge-policies
#>

# # # # # # # # # # # # # # # # # # # #
# параметр, задающий область применения политик
param(
	[Parameter()]
	[string]$scope = 'HKCU'
)

if ( ($scope -ne 'HKCU') -and ($scope -ne 'HKLM') ) {
	Write-Error 'Unacceptable scope. Use HKLM or HKCU.' -ErrorAction Stop
}

# # # # # # # # # # # # # # # # # # # #
# создание раздела форсируемых политик, если его нет
$path = "$($scope):SOFTWARE\Policies\Microsoft\Edge"
New-Item -Path $(Split-Path $path -Parent) -Name $(Split-Path $path -Leaf) -ErrorAction SilentlyContinue | Out-Null

# # # # # # # # # # # # # # # # # # # #
# первый запуск браузера

# отключить предложение первоначальной настройки персонализации
New-ItemProperty -Path $path -Name HideFirstRunExperience -Type Dword -Value 1 -Force | Out-Null
# запретить автоматический импорт данных из других браузеров
New-ItemProperty -Path $path -Name AutoImportAtFirstRun -Type Dword -Value 4 -Force | Out-Null
# запретить синхронизацию и предложение включить ее
New-ItemProperty -Path $path -Name SyncDisabled -Type Dword -Value 1 -Force | Out-Null
# запретить вход в браузер и предложение войти (также отключает синхронизацию)
New-ItemProperty -Path $path -Name BrowserSignin -Type Dword -Value 0 -Force | Out-Null

# # # # # # # # # # # # # # # # # # # #
# новая вкладка

# удалить заданные адреса домашней страницы и новой вкладки
Remove-ItemProperty -Path $path -Name HomePageLocation -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $path -Name NewTabPageLocation -ErrorAction SilentlyContinue

# вид и содержимое новой вкладки
New-ItemProperty -Path $path -Name NewTabPageContentEnabled -Type Dword -Value 0 -Force | Out-Null
New-ItemProperty -Path $path -Name NewTabPageQuickLinksEnabled -Type Dword -Value 0 -Force | Out-Null
New-ItemProperty -Path $path -Name NewTabPageHideDefaultTopSites -Type Dword -Value 1 -Force | Out-Null
# NewTabPageAllowedBackgroundTypes: DisableImageOfTheDay = 1, DisableCustomImage = 2, DisableAll = 3
New-ItemProperty -Path $path -Name NewTabPageAllowedBackgroundTypes -Type Dword -Value 3 -Force | Out-Null

# # # # # # # # # # # # # # # # # # # #
# прочие раздражители

# отключить кнопку бинг/копилот
# https://t.me/sterkin_ru/1465
New-ItemProperty -Path $path -Name HubsSidebarEnabled -Type Dword -Value 0 -Force | Out-Null
# отключить предложение персонализировать веб-серфинг
# https://t.me/sterkin_ru/1473
New-ItemProperty -Path $path -Name PersonalizationReportingEnabled -Type Dword -Value 0 -Force | Out-Null
# отключить переход в поисковик после ввода адреса сайта в адресную строку
# https://t.me/sterkin_ru/1514
New-ItemProperty -Path $path -Name SearchSuggestEnabled -Type Dword -Value 0 -Force | Out-Null
# отключить предложение восстановить страницы после неожиданного завершения работы
# https://t.me/sterkin_ru/1421
# New-ItemProperty -Path $path -Name HideRestoreDialogEnabled -Type Dword -Value 1 -Force | Out-Null
# отключить всякие рекомендации
New-ItemProperty -Path $path -Name SpotlightExperiencesAndRecommendationsEnabled -Type Dword -Value 0 -Force | Out-Null
New-ItemProperty -Path $path -Name ShowRecommendationsEnabled -Type Dword -Value 0 -Force | Out-Null
# отключить визуальный поиск (оверлей на изображениях)
New-ItemProperty -Path $path -Name VisualSearchEnabled -Type Dword -Value 0 -Force | Out-Null
# отключить мини-меню при выделении текста
New-ItemProperty -Path $path -Name QuickSearchShowMiniMenu -Type Dword -Value 0 -Force | Out-Null

# # # # # # # # # # # # # # # # # # # #
# применение настроек

# завершить все процессы браузера у текущего пользователя
Get-Process msedge -IncludeUserName -ErrorAction SilentlyContinue | Where-Object UserName -match $ENV:USERNAME | Stop-Process

# обновить политики
if ($scope -eq 'HKCU') { gpupdate /force /target:user }
else { gpupdate /force /target:computer }
