$computer_name = "DESKTOP-BEELINK"
$network_name = "SNR-CPE-EB9D"

$git_settings = @{user = 'vadim'; email = 'vadim@domain.com' }

# The following programs are installed with chocolatey. The first element is the
# program name and the second element are the optional arguments that are passed
# to the choco.
# @(program, args)
$install_apps = @(
	"7zip.7zip",
	"ajeetdsouza.zoxide",
	"BurntSushi.ripgrep.MSVC",
	"eza-community.eza",
	"Fastfetch-cli.Fastfetch",
	"FxSoundLLC.FxSound",
	"Git.Git",
	"GitHub.cli",
	"Gyan.FFmpeg",
	"Helix.Helix",
	"ImageMagick.ImageMagick",
	"JanDeDobbeleer.OhMyPosh",
	"JesseDuffield.lazygit",
	"jqlang.jq",
	"junegunn.fzf",
	"MicaForEveryone.MicaForEveryone",
	"Microsoft.DotNet.DesktopRuntime.3_1",
	"Microsoft.PowerToys",
	"Microsoft.VisualStudioCode",
	"Mozilla.Firefox",
	"mpv.net",
	"Neovim.Neovim",
	"Obsidian.Obsidian",
	"Oven-sh.Bun",
	"pnpm.pnpm",
	"qBittorrent.qBittorrent",
	"Schniz.fnm",
	"sharkdp.bat",
	"sharkdp.fd",
	"Starship.Starship",
	"Telegram.TelegramDesktop",
	"Ventoy.Ventoy",
	"Y2Z.Monolith",
	"Yandex.Browser",
	"yt-dlp.yt-dlp"
)

# The following built-in Windows features are disabled. The first element is the
# program name and the second element is the name of the feature.
# @(program, name)
$disable =
@("WindowsMediaPlayer", "Windows Media Player"),
@("Printing-XPSServices-Features", "Microsoft XPS Document Writer")

# The following pre-installed Windows programs are uninstalled.
$uninstall_apps = @(
	"Clipchamp.Clipchamp",
	"Microsoft.3DBuilder",
	"Microsoft.549981C3F5F10", #Cortana app
	"Microsoft.BingFinance",
	"Microsoft.BingFoodAndDrink",
	"Microsoft.BingHealthAndFitness",
	"Microsoft.BingNews",
	"Microsoft.BingSports",
	"Microsoft.BingTranslator",
	"Microsoft.BingTravel",
	"Microsoft.BingWeather",
	"Microsoft.Getstarted", # Cannot be uninstalled in Windows 11
	"Microsoft.Messaging",
	"Microsoft.Microsoft3DViewer",
	"Microsoft.MicrosoftJournal",
	"Microsoft.MicrosoftOfficeHub",
	"Microsoft.MicrosoftPowerBIForWindows",
	"Microsoft.MicrosoftSolitaireCollection",
	"Microsoft.MicrosoftStickyNotes",
	"Microsoft.MixedReality.Portal",
	"Microsoft.NetworkSpeedTest",
	"Microsoft.News",
	"Microsoft.Office.OneNote",
	"Microsoft.Office.Sway",
	"Microsoft.OneConnect",
	"Microsoft.Print3D",
	"Microsoft.SkypeApp",
	"Microsoft.Todos",
	"Microsoft.WindowsAlarms",
	"Microsoft.WindowsFeedbackHub",
	"Microsoft.WindowsMaps",
	"Microsoft.WindowsSoundRecorder",
	"Microsoft.XboxApp", # Old Xbox Console Companion App, no longer supported
	"Microsoft.ZuneVideo",
	"MicrosoftCorporationII.MicrosoftFamily", # Family Safety App
	"MicrosoftTeams", # Only removes the personal version (MS Store), does not remove business/enterprise version of teams

	"ACGMediaPlayer",
	"ActiproSoftwareLLC",
	"AdobeSystemsIncorporated.AdobePhotoshopExpress",
	"Amazon.com.Amazon",
	"AmazonVideo.PrimeVideo",
	"Asphalt8Airborne",
	"AutodeskSketchBook",
	"CaesarsSlotsFreeCasino",
	"COOKINGFEVER",
	"CyberLinkMediaSuiteEssentials",
	"DisneyMagicKingdoms",
	"Disney",
	"Dolby",
	"DrawboardPDF",
	"Duolingo-LearnLanguagesforFree",
	"EclipseManager",
	"Facebook",
	"FarmVille2CountryEscape",
	"fitbit",
	"Flipboard",
	"HiddenCity",
	"HULULLC.HULUPLUS",
	"iHeartRadio",
	"Instagram",
	"king.com.BubbleWitch3Saga",
	"king.com.CandyCrushSaga",
	"king.com.CandyCrushSodaSaga",
	"LinkedInforWindows",
	"MarchofEmpires",
	"Netflix",
	"NYTCrossword",
	"OneCalendar",
	"PandoraMediaInc",
	"PhototasticCollage",
	"PicsArt-PhotoStudio",
	"Plex",
	"PolarrPhotoEditorAcademicEdition",
	"Royal Revolt",
	"Shazam",
	"Sidia.LiveWallpaper",
	"SlingTV",
	"Speed Test",
	"Spotify",
	"TikTok",
	"TuneInRadio",
	"Twitter",
	"Viber",
	"WinZipUniversal",
	"Wunderlist",
	"XING",
	"Yandex.Music"
)

$tweaks = @(
	# Включить логирование работы скрипта. Лог будет записываться в папку скрипта. Чтобы остановить логгирование, закройте консоль или наберите "Stop-Transcript"
	# Logging

	# Создать точку восстановления
	CreateRestorePoint

	#region Privacy & Telemetry

	<#
	Отключить службу "Функциональные возможности для подключенных пользователей и телеметрия" (DiagTrack) и блокировать соединение для исходящего трафик клиента единой телеметрии
	Отключение службы "Функциональные возможности для подключенных пользователей и телеметрия" (DiagTrack) может привести к тому, что вы больше не сможете получать достижения Xbox, а также влияет на работу Feedback Hub
#>
	DiagTrackService -Disable # -Enable (значение по умолчанию), -Disable

	# Установить уровень сбора диагностических данных ОС на минимальный
	DiagnosticDataLevel -Minimal # -Default (значение по умолчанию), -Minimal

	# Отключить запись отчетов об ошибках Windows
	ErrorReporting -Disable # -Enable (значение по умолчанию), -Disable

	# Изменить частоту формирования отзывов на "Никогда"
	FeedbackFrequency -Never # -Automatically (значение по умолчанию), -Never

	# Не использовать данные для входа для автоматического завершения настройки устройства после перезапуска
	SigninInfo -Disable # -Enable (значение по умолчанию), -Disable

	# Не позволять веб-сайтам предоставлять местную информацию за счет доступа к списку языков
	LanguageListAccess -Disable # -Enable (значение по умолчанию), -Disable

	# Не разрешать приложениям показывать персонализированную рекламу с помощью моего идентификатора рекламы
	AdvertisingID -Disable # -Enable (значение по умолчанию), -Disable

	# Скрывать экран приветствия Windows после обновлений и иногда при входе, чтобы сообщить о новых функциях и предложениях
	WindowsWelcomeExperience -Hide # -Show (значение по умолчанию), -Hide

	# Не предлагать способы завершения настройки этого устройства для наиболее эффективного использования Windows
	WhatsNewInWindows -Disable # -Enable (значение по умолчанию), -Disable

	# Не получать советы и предложения при использованию Windows
	WindowsTips -Disable # -Enable (значение по умолчанию), -Disable

	# Скрывать рекомендуемое содержимое в приложении "Параметры"
	SettingsSuggestedContent -Hide # -Show (значение по умолчанию), -Hide

	# Отключить автоматическую установку рекомендованных приложений
	AppsSilentInstalling -Disable # -Enable (значение по умолчанию), -Disable

	# Не разрешать корпорации Майкрософт использовать диагностические данные персонализированных советов, рекламы и рекомендаций
	TailoredExperiences -Disable # -Enable (значение по умолчанию), -Disable

	# Отключить в меню "Пуск" поиск через Bing
	BingSearch -Disable # -Enable (значение по умолчанию), -Disable

	# Не показать веб-сайты из журнала браузера в меню "Пуск". Требуется Windows 11 build 23451 (Dev)
	BrowsingHistory -Hide # -Show (значение по умолчанию), -Hide
	#endregion Privacy & Telemetry

	#region UI & Personalization

	# Добавить поддержку миниатюр графического формата JPEG-XL
	JXLWinthumb

	# Отобразить скрытые файлы, папки и диски
	HiddenItems -Enable # -Disable (значение по умолчанию), -Enable

	# Отобразить расширения имён файлов
	FileExtensions -Show # -Hide (значение по умолчанию), --Show

	# Включить классическое контекстное меню, вернуть классическое контекстное меню
	ClassicContextMenu -Disable # -Disable (значение по умолчанию), -Enable

	# Скрыть галлерею в проводнике Windows
	Gallery -Hide # -Show (значение по умолчанию), -Hide

	# Отображать диалоговое окно передачи файлов в развернутом виде
	FileTransferDialog -Detailed # -Compact (значение по умолчанию), -Detailed

	# Скрыть недавно использовавшиеся файлы на панели быстрого доступа
	QuickAccessRecentFiles -Hide # -Show (значение по умолчанию), -Hide

	# Скрыть недавно используемые папки на панели быстрого доступа
	QuickAccessFrequentFolders -Hide # -Show (значение по умолчанию), -Hide

	# Скрыть отображение файлов из Office.com в проводнике
	ShowFilesOffice -Hide # -Show (значение по умолчанию), -Hide

	# Скрыть кнопку "Мини-приложения" с панели задач
	TaskbarWidgets -Show # -Show (значение по умолчанию), -Hide

	# Поиск на панели задач (поле поиска, значок и метку поиска, значок поиска и скрытие поиска)
	TaskbarSearch -SearchIconLabel # -SearchBox (значение по умолчанию), -SearchIconLabel, -SearchIcon, -Hide

	# Скрыть главное в поиске
	SearchHighlights -Hide # -Show (значение по умолчанию), -Hide

	# Скрыть кнопку Copilot с панели задач
	CopilotButton -Hide # -Show (значение по умолчанию), -Hide

	# Скрыть кнопку "Представление задач" с панели задач
	TaskViewButton -Hide # -Show (значение по умолчанию), -Hide

	# Скрыть кнопку чата (Microsoft Teams) с панели задач и запретить установку Microsoft Teams для новых пользователей
	PreventTeamsInstallation -Enable # -Disable (значение по умолчанию), -Enable

	# Просмотр иконок Панели управления как: крупные значки
	ControlPanelView -LargeIcons # -Category (значение по умолчанию), -SmallIcons, -LargeIcons

	# Установить режим Windows по умолчанию на темный
	WindowsColorMode -Dark # -Light (значение по умолчанию), -Dark

	# Установить цвет режима приложения на темный
	AppColorMode -Dark # -Light (значение по умолчанию), -Dark

	# Скрывать анимацию при первом входе в систему после обновления
	FirstLogonAnimation -Disable # -Enable (значение по умолчанию), -Disable

	# Установить коэффициент качества обоев рабочего стола в формате JPEG на максимальный
	JPEGWallpapersQuality -Default # -Default (значение по умолчанию), -Max

	# Нe дoбaвлять "- яpлык" к имени coздaвaeмых яpлыков
	ShortcutsSuffix -Disable # -Enable (значение по умолчанию), -Disable

	# Использовать кнопку PRINT SCREEN, чтобы запустить функцию создания фрагмента экрана
	PrtScnSnippingTool -Enable # -Disable (значение по умолчанию), -Enable

	# Не использовать метод ввода для каждого окна
	AppsLanguageSwitch -Disable # -Disable (значение по умолчанию), -Enable

	# При захвате заголовка окна и встряхивании сворачиваются все остальные окна
	AeroShaking -Enable # -Disable (значение по умолчанию), -Enable

	# Скачать и установить бесплатные темные курсоры "Windows 11 Cursors Concept v2" от Jepri Creations
	Cursors -Dark # -Default (значение по умолчанию), -Dark, -Light

	# Не группировать файлы и папки в папке Загрузки
	FolderGroupBy -Default # -Default (значение по умолчанию), -None
	#endregion UI & Personalization

	#region System
	#region StorageSense

	# Включить Контроль памяти
	StorageSense -Enable # -Disable (значение по умолчанию), -Enable

	# Запускать Контроль памяти каждый месяц
	StorageSenseFrequency -Month # -Default (значение по умолчанию), -Month

	# Автоматически очищать временные файлы системы и приложений (значение по умолчанию)
	StorageSenseTempFiles -Enable # -Enable (значение по умолчанию), -Disable
	#endregion StorageSense

	# Отображать код Stop-ошибки при появлении BSoD
	BSoDStopError -Enable # -Disable (значение по умолчанию), -Enable

	# Настройка уведомления об изменении параметров компьютера: никогда не уведомлять
	AdminApprovalMode -Default # -Default (значение по умолчанию), -Never

	# Включить доступ к сетевым дискам при включенном режиме одобрения администратором при доступе из программ, запущенных с повышенными правами
	MappedDrivesAppElevatedAccess -Enable # -Disable (значение по умолчанию), -Enable

	# Выключить оптимизацию доставки
	DeliveryOptimization -Disable # -Enable (значение по умолчанию), -Disable

	# Получать обновления для других продуктов Майкрософт
	UpdateMicrosoftProducts -Enable # -Disable (значение по умолчанию), -Enable

	# Получайте последние обновления, как только они будут доступны
	WindowsLatestUpdate -Enable # -Disable (значение по умолчанию), -Enable

	# Установить схему управления питанием на "Высокая производительность". Не рекомендуется включать на ноутбуках
	PowerPlan -High # -Balanced (значение по умолчанию), -High

	# Отключить режим гибернации. Не рекомендуется выключать на ноутбуках
	Hibernation -Disable # -Enable (значение по умолчанию), -Disable

	# Включить Num Lock при загрузке
	NumLock -Enable # -Disable (значение по умолчанию), -Enable

	# Выключить залипание клавиши Shift после 5 нажатий
	StickyShift -Disable # -Enable (значение по умолчанию), -Disable

	# Не использовать автозапуск для всех носителей и устройств
	Autoplay -Disable # -Enable (значение по умолчанию), -Disable

	# Включить сетевое обнаружение и общий доступ к файлам и принтерам для рабочих групп
	NetworkDiscovery -Enable # -Disable (значение по умолчанию), -Enable

	# Установить Windows Terminal как приложение терминала по умолчанию для размещения пользовательского интерфейса для приложений командной строки
	DefaultTerminalApp -WindowsTerminal # -ConsoleHost (значение по умолчанию), -WindowsTerminal

	# Включить проксирование только заблокированных сайтов из единого реестра Роскомнадзора. Функция применима только для России
	# https://antizapret.prostovpn.org
	RKNBypass -Disable # -Disable (значение по умолчанию), -Enable

	#region Start menu

	# Макет начального экрана (Отображать больше закреплений на начальном экране или больше рекомендаций)
	StartLayout -ShowMorePins # -Default (значение по умолчанию), -ShowMorePins, -ShowMoreRecommendations

	#endregion Start menu

	# Выключить автозагрузку Microsoft Teams
	TeamsAutostart -Disable # -Enable (значение по умолчанию), -Disable

	# Отклонить предложение Microsoft Defender в "Безопасность Windows" о входе в аккаунт Microsoft
	DismissMSAccount

	# Отклонить предложение Microsoft Defender в "Безопасность Windows" включить фильтр SmartScreen для Microsoft Edge
	DismissSmartScreenFilter

	# Включить ведение журнала для всех модулей Windows PowerShell
	PowerShellModulesLogging -Enable # -Disable (значение по умолчанию), -Enable

	# Включить ведение журнала для всех вводимых сценариев PowerShell в журнале событий Windows PowerShell
	PowerShellScriptsLogging -Enable # -Disable (значение по умолчанию), -Enable

	# Microsoft Defender SmartScreen не помечает скачанные файлы из интернета как небезопасные
	AppsSmartScreen -Disable # -Enable (значение по умолчанию), -Disable

	# Выключить проверку Диспетчером вложений файлов, скачанных из интернета, как небезопасные
	SaveZoneInformation -Disable # -Enable (значение по умолчанию), -Disable

	<#
	Включить DNS-over-HTTPS для IPv4
	Действительные IPv4-адреса: 1.0.0.1, 1.1.1.1, 149.112.112.112, 8.8.4.4, 8.8.8.8, 9.9.9.9 или
	Включить DNS-over-HTTPS для IPv4 через DNS-сервер Comss.one. Применимо только для России
#>
	DNSoverHTTPS -Disable # -Disable (значение по умолчанию), -Enable -PrimaryDNS 1.1.1.1 -SecondaryDNS 1.0.0.1, -ComssOneDNS

	# Отобразить пункт "Открыть в Терминале Windows" в контекстном меню папок
	OpenWindowsTerminalContext -Show # -Show (значение по умолчанию), -Hide

	# Открывать Windows Terminal из контекстного меню от имени администратора по умолчанию или скрыть пункт
	OpenWindowsTerminalAdminContext -Disable # -Disable (значение по умолчанию), -Enable, -Hide
)
