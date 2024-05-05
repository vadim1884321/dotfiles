ConvertFrom-StringData -StringData @'
UnsupportedOSBuild                        = 脚本支持Windows 11 23H2+。
UpdateWarning                             = 您的Windows 11构建: {0}.{1}。支持的构建: {2}+。运行Windows Update并再次尝试。
UnsupportedLanguageMode                   = PowerShell会话在有限的语言模式下运行。
LoggedInUserNotAdmin                      = 登录的用户没有管理员的权利。
UnsupportedPowerShell                     = 你想通过PowerShell {0}.{1}运行脚本。在适当的PowerShell版本中运行该脚本。
PowerShellx86Warning                      = 您正尝试在 PowerShell (x86) 中运行脚本。在 PowerShell (x64) 中运行脚本。
UnsupportedHost                           = 该脚本不支持通过{0}运行。
Win10TweakerWarning                       = 可能你的操作系统是通过"Win 10 Tweaker"后门感染的。
TweakerWarning                            = Windows的稳定性可能已被{0}所破坏。预防性地，重新安装整个操作系统。
Bin                                       = bin文件夹中没有文件。请重新下载该档案。
RebootPending                             = 计算机正在等待重新启动。
UnsupportedRelease                        = 找到新版本。
KeyboardArrows                            = 请使用键盘上的方向键{0}和{1}选择您的答案
CustomizationWarning                      = 在运行Sophia Script之前，您是否已自定义{0}预设文件中的每个函数？
WindowsComponentBroken                    = {0} 损坏或从操作系统中删除。
UpdateDefender                            = Microsoft Defender的定义已经过期。运行Windows Update并再次尝试。
ControlledFolderAccessDisabled            = "受控文件夹访问"已禁用。
InitialActionsCheckFailed                 = 无法从{0}预置文件中加载 "InitialActions "功能。
ScheduledTasks                            = 计划任务
OneDriveUninstalling                      = 卸载OneDrive.....
OneDriveInstalling                        = OneDrive正在安装.....
OneDriveDownloading                       = 正在下载OneDrive.....
OneDriveWarning                           = 只有当预设被配置为删除OneDrive（或应用程序已经被删除）时，才会应用"{0}"功能，否则OneDrive中 "桌面 "和 "图片 "文件夹的备份功能就会中断。
WindowsFeaturesTitle                      = Windows功能
OptionalFeaturesTitle                     = 可选功能
EnableHardwareVT                          = UEFI中开启虚拟化。
UserShellFolderNotEmpty                   = 一些文件留在了"{0}"文件夹。请手动将它们移到一个新位置。
UserFolderLocationMove                    = 不应将用户文件夹位置更改为 C 盘根目录。
RetrievingDrivesList                      = 取得驱动器列表.....
DriveSelect                               = 选择将在其根目录中创建"{0}"文件夹的驱动器。
CurrentUserFolderLocation                 = 当前"{0}"文件夹的位置:"{1}"。
UserFolderRequest                         = 是否要更改"{0}"文件夹位置？
UserDefaultFolder                         = 您想将"{0}"文件夹的位置更改为默认值吗？
ReservedStorageIsInUse                    = 保留存储空间正在使用时不支持此操作\n请在电脑重启后重新运行"{0}"功能。
ShortcutPinning                           = "{0}"快捷方式将被固定到开始菜单.....
SSDRequired                               = 要在您的设备上使用Windows Subsystem for Android™，您的电脑需要安装固态驱动器（SSD）。
UninstallUWPForAll                        = 对于所有用户
UWPAppsTitle                              = UWP应用
GraphicsPerformanceTitle                  = 是否将所选应用程序的图形性能设置设为"高性能"？
ActionCenter                              = 为了使用"{0}"功能，你必须启用行动中心。
WindowsScriptHost                         = 没有在该机执行 Windows 脚本宿主的权限。请与系统管理员联系。 为了使用"{0}"功能，你必须启用Windows脚本主机。
ScheduledTaskPresented                    = "{0}"函数已经被创建为"{1}"。
CleanupTaskNotificationTitle              = Windows清理
CleanupTaskNotificationEvent              = 运行任务以清理Windows未使用的文件和更新？
CleanupTaskDescription                    = 使用内置磁盘清理工具清理未使用的Windows文件和更新。
CleanupNotificationTaskDescription        = 关于清理Windows未使用的文件和更新的弹出通知提醒。
SoftwareDistributionTaskNotificationEvent = Windows更新缓存已成功删除。
TempTaskNotificationEvent                 = 临时文件文件夹已成功清理。
FolderTaskDescription                     = "{0}"文件夹清理。
EventViewerCustomViewName                 = 进程创建
EventViewerCustomViewDescription          = 进程创建和命令行审核事件。
RestartWarning                            = 确保重启电脑。
ErrorsLine                                = 行
ErrorsMessage                             = 错误/警告
DialogBoxOpening                          = 显示对话窗口.....
Disable                                   = 禁用
Enable                                    = 启用
UserChoiceWarning                         = 微软在发布 KB5034765 时阻止了对 .pdf 扩展和 http/https 协议的 UserChoice 密钥的写入访问。
AllFilesFilter                            = 所有文件
FolderSelect                              = 选择一个文件夹
FilesWontBeMoved                          = 文件将不会被移动。
Install                                   = 安装
NoData                                    = 无数据。
NoInternetConnection                      = 无网络连接。
RestartFunction                           = 请重新运行"{0}"函数。
NoResponse                                = 无法建立{0}。
Restore                                   = 恢复
Run                                       = 运行
Skipped                                   = 已跳过。
GPOUpdate                                 = GPO更新.....
TelegramGroupTitle                        = 加入我们的官方Telegram 群。
TelegramChannelTitle                      = 加入我们的官方Telegram 频道。
DiscordChannelTitle                       = 加入我们的官方Discord 频道。
Uninstall                                 = 卸载
'@

# SIG # Begin signature block
# MIIbswYJKoZIhvcNAQcCoIIbpDCCG6ACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBz3JSiccZt57Fq
# eTpkLtQdB7pyk3OeSppA1IYhCYMmjKCCFgkwggL8MIIB5KADAgECAhBUm8fhP7ik
# pEAOlST8/xQoMA0GCSqGSIb3DQEBCwUAMBYxFDASBgNVBAMMC1RlYW0gU29waGlh
# MB4XDTI0MDQxNDEyMTAyN1oXDTI2MDQxNDEyMjAyNlowFjEUMBIGA1UEAwwLVGVh
# bSBTb3BoaWEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvJAyx9NqQ
# HNk0QQMOJp2FnMJnbWLXkQEnssXJo40/iZvaMmPcTBQnNUAZsf/cRjWlRna8Bif8
# d8G+PHvQbSq4P6Fx83mR+kIp0Nhk3EJ36/wGEZ5B6ueYmEIuDzdNerJGbFpM6uXA
# c+aJ7FdIhOwJtPVt0G59MccUHy3lPeJZ2YCddO6nScbd4UgfuG1tp98sO+XiIWlR
# SB78EzayyZG5rA/xHWVfipNXGc/BdIKRNlwyeuR6tlDD2zIq4Yd7vfSDaEQE8WKx
# PVdAZc6+7H3VDw+0NQ56DEaCp/jq3eLzhZ6WrUaPkEz2BnN+cEDMxDRiNnqy6Y3+
# ORizQ7meCmTpAgMBAAGjRjBEMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggr
# BgEFBQcDAzAdBgNVHQ4EFgQUpi2webqdmhYA4zPmK+xAHphAbzEwDQYJKoZIhvcN
# AQELBQADggEBAGhAkgNqYRQrONNiPl+nbpFIZARczN8hqdoZYi7XRL5qaL8QcoKO
# LfQ87Ri+/+Qzw9vhEt7XKfGCejXQnqrvY7ASINNV8Q2A3V5ybFKihv6xYFu+9a6l
# rGgYHT9c11BOMghaR1ncg7MyPdXYtLxmxWOl/3LmgdInGuh/x9sSkFfFg13CuS2j
# Q7FFczSsBwHU+N5eZAO21R6PnbE4F8qrXBfCecvCRMntj9Ht6bjpp68VFLJwGkh9
# +Mbl8ahXazmJWyKWCOu4kmAbvQWSSPfeuNp+Tht+y1X89CziWdMw5XcGqhCo/UCE
# Fy0c0Xc7YfVerN/KeQLkwaFW99fXVXgo7u4wggWNMIIEdaADAgECAhAOmxiO+dAt
# 5+/bUOIIQBhaMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAiBgNV
# BAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yMjA4MDEwMDAwMDBa
# Fw0zMTExMDkyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2Vy
# dCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lD
# ZXJ0IFRydXN0ZWQgUm9vdCBHNDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoC
# ggIBAL/mkHNo3rvkXUo8MCIwaTPswqclLskhPfKK2FnC4SmnPVirdprNrnsbhA3E
# MB/zG6Q4FutWxpdtHauyefLKEdLkX9YFPFIPUh/GnhWlfr6fqVcWWVVyr2iTcMKy
# unWZanMylNEQRBAu34LzB4TmdDttceItDBvuINXJIB1jKS3O7F5OyJP4IWGbNOsF
# xl7sWxq868nPzaw0QF+xembud8hIqGZXV59UWI4MK7dPpzDZVu7Ke13jrclPXuU1
# 5zHL2pNe3I6PgNq2kZhAkHnDeMe2scS1ahg4AxCN2NQ3pC4FfYj1gj4QkXCrVYJB
# MtfbBHMqbpEBfCFM1LyuGwN1XXhm2ToxRJozQL8I11pJpMLmqaBn3aQnvKFPObUR
# WBf3JFxGj2T3wWmIdph2PVldQnaHiZdpekjw4KISG2aadMreSx7nDmOu5tTvkpI6
# nj3cAORFJYm2mkQZK37AlLTSYW3rM9nF30sEAMx9HJXDj/chsrIRt7t/8tWMcCxB
# YKqxYxhElRp2Yn72gLD76GSmM9GJB+G9t+ZDpBi4pncB4Q+UDCEdslQpJYls5Q5S
# UUd0viastkF13nqsX40/ybzTQRESW+UQUOsxxcpyFiIJ33xMdT9j7CFfxCBRa2+x
# q4aLT8LWRV+dIPyhHsXAj6KxfgommfXkaS+YHS312amyHeUbAgMBAAGjggE6MIIB
# NjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTs1+OC0nFdZEzfLmc/57qYrhwP
# TzAfBgNVHSMEGDAWgBRF66Kv9JLLgjEtUYunpyGd823IDzAOBgNVHQ8BAf8EBAMC
# AYYweQYIKwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdp
# Y2VydC5jb20wQwYIKwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNv
# bS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0
# aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENB
# LmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQEMBQADggEBAHCgv0Nc
# Vec4X6CjdBs9thbX979XB72arKGHLOyFXqkauyL4hxppVCLtpIh3bb0aFPQTSnov
# Lbc47/T/gLn4offyct4kvFIDyE7QKt76LVbP+fT3rDB6mouyXtTP0UNEm0Mh65Zy
# oUi0mcudT6cGAxN3J0TU53/oWajwvy8LpunyNDzs9wPHh6jSTEAZNUZqaVSwuKFW
# juyk1T3osdz9HNj0d1pcVIxv76FQPfx2CWiEn2/K2yCNNWAcAgPLILCsWKAOQGPF
# mCLBsln1VWvPJ6tsds5vIy30fnFqI2si/xK4VC0nftg62fC2h5b9W9FcrBjDTZ9z
# twGpn1eqXijiuZQwggauMIIElqADAgECAhAHNje3JFR82Ees/ShmKl5bMA0GCSqG
# SIb3DQEBCwUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMx
# GTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0IFRy
# dXN0ZWQgUm9vdCBHNDAeFw0yMjAzMjMwMDAwMDBaFw0zNzAzMjIyMzU5NTlaMGMx
# CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE7MDkGA1UEAxMy
# RGlnaUNlcnQgVHJ1c3RlZCBHNCBSU0E0MDk2IFNIQTI1NiBUaW1lU3RhbXBpbmcg
# Q0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDGhjUGSbPBPXJJUVXH
# JQPE8pE3qZdRodbSg9GeTKJtoLDMg/la9hGhRBVCX6SI82j6ffOciQt/nR+eDzMf
# UBMLJnOWbfhXqAJ9/UO0hNoR8XOxs+4rgISKIhjf69o9xBd/qxkrPkLcZ47qUT3w
# 1lbU5ygt69OxtXXnHwZljZQp09nsad/ZkIdGAHvbREGJ3HxqV3rwN3mfXazL6IRk
# tFLydkf3YYMZ3V+0VAshaG43IbtArF+y3kp9zvU5EmfvDqVjbOSmxR3NNg1c1eYb
# qMFkdECnwHLFuk4fsbVYTXn+149zk6wsOeKlSNbwsDETqVcplicu9Yemj052FVUm
# cJgmf6AaRyBD40NjgHt1biclkJg6OBGz9vae5jtb7IHeIhTZgirHkr+g3uM+onP6
# 5x9abJTyUpURK1h0QCirc0PO30qhHGs4xSnzyqqWc0Jon7ZGs506o9UD4L/wojzK
# QtwYSH8UNM/STKvvmz3+DrhkKvp1KCRB7UK/BZxmSVJQ9FHzNklNiyDSLFc1eSuo
# 80VgvCONWPfcYd6T/jnA+bIwpUzX6ZhKWD7TA4j+s4/TXkt2ElGTyYwMO1uKIqjB
# Jgj5FBASA31fI7tk42PgpuE+9sJ0sj8eCXbsq11GdeJgo1gJASgADoRU7s7pXche
# MBK9Rp6103a50g5rmQzSM7TNsQIDAQABo4IBXTCCAVkwEgYDVR0TAQH/BAgwBgEB
# /wIBADAdBgNVHQ4EFgQUuhbZbU2FL3MpdpovdYxqII+eyG8wHwYDVR0jBBgwFoAU
# 7NfjgtJxXWRM3y5nP+e6mK4cD08wDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQMMAoG
# CCsGAQUFBwMIMHcGCCsGAQUFBwEBBGswaTAkBggrBgEFBQcwAYYYaHR0cDovL29j
# c3AuZGlnaWNlcnQuY29tMEEGCCsGAQUFBzAChjVodHRwOi8vY2FjZXJ0cy5kaWdp
# Y2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9vdEc0LmNydDBDBgNVHR8EPDA6MDig
# NqA0hjJodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9v
# dEc0LmNybDAgBgNVHSAEGTAXMAgGBmeBDAEEAjALBglghkgBhv1sBwEwDQYJKoZI
# hvcNAQELBQADggIBAH1ZjsCTtm+YqUQiAX5m1tghQuGwGC4QTRPPMFPOvxj7x1Bd
# 4ksp+3CKDaopafxpwc8dB+k+YMjYC+VcW9dth/qEICU0MWfNthKWb8RQTGIdDAiC
# qBa9qVbPFXONASIlzpVpP0d3+3J0FNf/q0+KLHqrhc1DX+1gtqpPkWaeLJ7giqzl
# /Yy8ZCaHbJK9nXzQcAp876i8dU+6WvepELJd6f8oVInw1YpxdmXazPByoyP6wCeC
# RK6ZJxurJB4mwbfeKuv2nrF5mYGjVoarCkXJ38SNoOeY+/umnXKvxMfBwWpx2cYT
# gAnEtp/Nh4cku0+jSbl3ZpHxcpzpSwJSpzd+k1OsOx0ISQ+UzTl63f8lY5knLD0/
# a6fxZsNBzU+2QJshIUDQtxMkzdwdeDrknq3lNHGS1yZr5Dhzq6YBT70/O3itTK37
# xJV77QpfMzmHQXh6OOmc4d0j/R0o08f56PGYX/sr2H7yRp11LB4nLCbbbxV7HhmL
# NriT1ObyF5lZynDwN7+YAN8gFk8n+2BnFqFmut1VwDophrCYoCvtlUG3OtUVmDG0
# YgkPCr2B2RP+v6TR81fZvAT6gt4y3wSJ8ADNXcL50CN/AAvkdgIm2fBldkKmKYcJ
# RyvmfxqkhQ/8mJb2VVQrH4D6wPIOK+XW+6kvRBVK5xMOHds3OBqhK/bt1nz8MIIG
# wjCCBKqgAwIBAgIQBUSv85SdCDmmv9s/X+VhFjANBgkqhkiG9w0BAQsFADBjMQsw
# CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOzA5BgNVBAMTMkRp
# Z2lDZXJ0IFRydXN0ZWQgRzQgUlNBNDA5NiBTSEEyNTYgVGltZVN0YW1waW5nIENB
# MB4XDTIzMDcxNDAwMDAwMFoXDTM0MTAxMzIzNTk1OVowSDELMAkGA1UEBhMCVVMx
# FzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMSAwHgYDVQQDExdEaWdpQ2VydCBUaW1l
# c3RhbXAgMjAyMzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAKNTRYcd
# g45brD5UsyPgz5/X5dLnXaEOCdwvSKOXejsqnGfcYhVYwamTEafNqrJq3RApih5i
# Y2nTWJw1cb86l+uUUI8cIOrHmjsvlmbjaedp/lvD1isgHMGXlLSlUIHyz8sHpjBo
# yoNC2vx/CSSUpIIa2mq62DvKXd4ZGIX7ReoNYWyd/nFexAaaPPDFLnkPG2ZS48jW
# Pl/aQ9OE9dDH9kgtXkV1lnX+3RChG4PBuOZSlbVH13gpOWvgeFmX40QrStWVzu8I
# F+qCZE3/I+PKhu60pCFkcOvV5aDaY7Mu6QXuqvYk9R28mxyyt1/f8O52fTGZZUdV
# nUokL6wrl76f5P17cz4y7lI0+9S769SgLDSb495uZBkHNwGRDxy1Uc2qTGaDiGhi
# u7xBG3gZbeTZD+BYQfvYsSzhUa+0rRUGFOpiCBPTaR58ZE2dD9/O0V6MqqtQFcmz
# yrzXxDtoRKOlO0L9c33u3Qr/eTQQfqZcClhMAD6FaXXHg2TWdc2PEnZWpST618Rr
# IbroHzSYLzrqawGw9/sqhux7UjipmAmhcbJsca8+uG+W1eEQE/5hRwqM/vC2x9XH
# 3mwk8L9CgsqgcT2ckpMEtGlwJw1Pt7U20clfCKRwo+wK8REuZODLIivK8SgTIUlR
# fgZm0zu++uuRONhRB8qUt+JQofM604qDy0B7AgMBAAGjggGLMIIBhzAOBgNVHQ8B
# Af8EBAMCB4AwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAg
# BgNVHSAEGTAXMAgGBmeBDAEEAjALBglghkgBhv1sBwEwHwYDVR0jBBgwFoAUuhbZ
# bU2FL3MpdpovdYxqII+eyG8wHQYDVR0OBBYEFKW27xPn783QZKHVVqllMaPe1eNJ
# MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
# Q2VydFRydXN0ZWRHNFJTQTQwOTZTSEEyNTZUaW1lU3RhbXBpbmdDQS5jcmwwgZAG
# CCsGAQUFBwEBBIGDMIGAMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2Vy
# dC5jb20wWAYIKwYBBQUHMAKGTGh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9E
# aWdpQ2VydFRydXN0ZWRHNFJTQTQwOTZTSEEyNTZUaW1lU3RhbXBpbmdDQS5jcnQw
# DQYJKoZIhvcNAQELBQADggIBAIEa1t6gqbWYF7xwjU+KPGic2CX/yyzkzepdIpLs
# jCICqbjPgKjZ5+PF7SaCinEvGN1Ott5s1+FgnCvt7T1IjrhrunxdvcJhN2hJd6Pr
# kKoS1yeF844ektrCQDifXcigLiV4JZ0qBXqEKZi2V3mP2yZWK7Dzp703DNiYdk9W
# uVLCtp04qYHnbUFcjGnRuSvExnvPnPp44pMadqJpddNQ5EQSviANnqlE0PjlSXcI
# WiHFtM+YlRpUurm8wWkZus8W8oM3NG6wQSbd3lqXTzON1I13fXVFoaVYJmoDRd7Z
# ULVQjK9WvUzF4UbFKNOt50MAcN7MmJ4ZiQPq1JE3701S88lgIcRWR+3aEUuMMsOI
# 5ljitts++V+wQtaP4xeR0arAVeOGv6wnLEHQmjNKqDbUuXKWfpd5OEhfysLcPTLf
# ddY2Z1qJ+Panx+VPNTwAvb6cKmx5AdzaROY63jg7B145WPR8czFVoIARyxQMfq68
# /qTreWWqaNYiyjvrmoI1VygWy2nyMpqy0tg6uLFGhmu6F/3Ed2wVbK6rr3M66ElG
# t9V/zLY4wNjsHPW2obhDLN9OTH0eaHDAdwrUAuBcYLso/zjlUlrWrBciI0707NMX
# +1Br/wd3H3GXREHJuEbTbDJ8WC9nR2XlG3O2mflrLAZG70Ee8PBf4NvZrZCARK+A
# EEGKMYIFADCCBPwCAQEwKjAWMRQwEgYDVQQDDAtUZWFtIFNvcGhpYQIQVJvH4T+4
# pKRADpUk/P8UKDANBglghkgBZQMEAgEFAKCBhDAYBgorBgEEAYI3AgEMMQowCKAC
# gAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsx
# DjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCAE8GaQEEZ6jgH57cu0cGiC
# yJB0vI8RuAHSf9DVSIyfjTANBgkqhkiG9w0BAQEFAASCAQBujrE0dyAWoEtZBlt4
# QLKjdHI+afkyiULDXimQEJd9ida5UqJApTXbKi7t6T1ITRa2l0rzK1rj1811iBcS
# RBWkYG6BJh56g6ZeCRv+7lFBuQY6EN65rVBZ0hzIHqvtI0kvrPbE3P8LxjdQVqhh
# 72SWOTA/oQ16yU3BCoomVbIJaJOl5TdjPNNBnPBxZx1QN875dAYShIopdsD/L1T5
# fbED9EP8ZqmcVO+/fvWSg9aAVpXW8IGU3T1EslJhfaTUi5sMNM+VeiVmk4oMfKYR
# rJC8ByB2ytmCQgdSZBntevBQYz4mXaypUX3rpFPW8JxKX7FIPAA0RVh51IUw/QKQ
# uvt7oYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJAgEBMHcwYzELMAkGA1UEBhMC
# VVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBU
# cnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBDQQIQBUSv85Sd
# CDmmv9s/X+VhFjANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG
# 9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNDEyMjAzN1owLwYJKoZIhvcNAQkE
# MSIEIPnLgZG2KJgR3Dh497+9r3NRTwVaDAU85cPpl4z5O2tgMA0GCSqGSIb3DQEB
# AQUABIICAJCZduK3ddb+uiAdm7cTfBKNRcYYrGz+WkwUWA1HHzwkusEQsG0eIEgX
# Sw1UbKgMrNlBvv7uo7D7t5cgKmLPmUaeim3Pr+mMIaoMmYnOIoNeCgznJPzHMwm7
# HYNGjWqqZR/LL6ok5sGK2gwdGa/YRlJCM78afrfp6QDqZ2cFRsDpziyipHOpqQkR
# 3Z6BL2j+Ckr7tjyXbgdpZrvHIlNcdBqndHJmgRcvofKeC+RVcAT3O3UOUIuB2pOr
# zvwJ/KWQ7BtzHBwXgGdZSbck+OYEyrYshjY/YkUw6VdFgxxSK+H4+iuP565ckvfv
# 4n/AFQSPUspyPdu/6p47KYntGGlhsJiPzZrJ+R7lTyGv4oeJzE9KVNHIcXVhdisT
# YeQr905eq/3Z4t8t4Xa+oPNseoI7nDAE+1wgG9H8t45d62vnEAoXe4irwof0IBqv
# LPC22Cx5FRrLrWlMpOQOr/31aKpmZguHeGzvMy6pgDWpXDG2bdqxXmzQyCV98NZm
# pfXethltkWskQoJGKkdXzcrkozxjgqrE/QH9sMCcs5BVTsDM2laeRbbh9Qj5IIJG
# TlrBOg6H+ki/AXbRJL5F1ed30uehJAhfEJ5cselQoGBDTbohdHAHlIrbMhcU9Dij
# OyV40J3y9g83dVv2Nn3ySVSFK1OVRV/4UeDf0JhC1u+svT2FP6Tl
# SIG # End signature block
