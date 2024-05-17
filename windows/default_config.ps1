$computer_name = "DESKTOP-BEELINK"
$network_name = "SNR-CPE-EB9D"

$git_settings = @{user = 'vadim'; email = 'vadim@domain.com' }

# The following programs are installed with chocolatey. The first element is the
# program name and the second element are the optional arguments that are passed
# to the choco.
# @(program, args)
$install = @(
	@{name = "Microsoft.WindowsTerminal"; source = "msstore" },
	@{name = "Microsoft.PowerShell" },
	@{name = "Microsoft.OpenSSH.Beta" },
	@{name = "JanDeDobbeleer.OhMyPosh" },
	@{name = "Git.Git" },
	@{name = "GitHub.cli" },
	@{name = "Microsoft.VisualStudioCode" },
	@{name = "Neovim.Neovim" },
	@{name = "Obsidian.Obsidian" },
	@{name = "Microsoft.PowerToys" },
	@{name = "Yandex.Browser" },
	@{name = "Mozilla.Firefox" },
	@{name = "7zip.7zip" },
	@{name = "agalwood.Motrix" },
	# @{name = "qBittorrent.qBittorrent" },
	# @{name = "MicaForEveryone.MicaForEveryone" },
	# @{name = "Microsoft.DotNet.DesktopRuntime.3_1" },
	@{name = "Telegram.TelegramDesktop" },
	@{name = "Gyan.FFmpeg" },
	@{name = "yt-dlp.yt-dlp" },
	@{name = "ImageMagick.ImageMagick" },
	@{name = "eza-community.eza" },
	@{name = "sharkdp.bat" },
	@{name = "junegunn.fzf" },
	@{name = "ajeetdsouza.zoxide" }
	# @{name = "FxSoundLLC.FxSound" }
)

# The following built-in Windows features are disabled. The first element is the
# program name and the second element is the name of the feature.
# @(program, name)
$disable =
@("WindowsMediaPlayer", "Windows Media Player"),
@("Printing-XPSServices-Features", "Microsoft XPS Document Writer")

# The following pre-installed Windows programs are uninstalled.
$uninstall = @(
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
	"Yandex.Music")

