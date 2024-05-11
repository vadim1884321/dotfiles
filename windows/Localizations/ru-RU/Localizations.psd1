ConvertFrom-StringData -StringData @'
CreateRestorePoint                        = Создать точку восстановления
testEnable                                = Включено
UnsupportedOSBuild                        = Скрипт поддерживает Windows 11 23H2+.
UpdateWarning                             = Ваш билд Windows 11: {0}.{1}. Поддерживаемые сборки: {2}+. Запустите обновление Windows и попробуйте заново.
UnsupportedLanguageMode                   = Сессия PowerShell работает в ограниченном режиме.
LoggedInUserNotAdmin                      = Текущий вошедший пользователь не обладает правами администратора.
UnsupportedPowerShell                     = Вы пытаетесь запустить скрипт в PowerShell {0}.{1}. Запустите скрипт в соответствующей версии PowerShell.
PowerShellx86Warning                      = Вы пытаетесь запустить скрипт в PowerShell (x86). Запустите скрипт в PowerShell (x64).
UnsupportedHost                           = Скрипт не поддерживает работу через {0}.
Win10TweakerWarning                       = Ваша ОС, возможно, через бэкдор в Win 10 Tweaker была заражена трояном.
TweakerWarning                            = Стабильность Windows могла быть нарушена использованием {0}. На всякий случай переустановите Windows.
Bin                                       = В папке bin отсутствуют файлы. Пожалуйста, перекачайте архив.
RebootPending                             = Компьютер ожидает перезагрузки.
UnsupportedRelease                        = Обнаружена новая версия.
KeyboardArrows                            = Для выбора используйте на клавиатуре стрелки {0} и {1}
CustomizationWarning                      = Вы настроили все функции в пресет-файле {0} перед запуском Sophia Script?
WindowsComponentBroken                    = {0} сломан или удален из ОС.
UpdateDefender                            = Определения Microsoft Defender устарели. Запустите обновление Windows.
ControlledFolderAccessDisabled            = Контролируемый доступ к папкам выключен.
InitialActionsCheckFailed                 = Функция "InitialActions" не может быть загружена из пресет-файла {0}.
ScheduledTasks                            = Запланированные задания
OneDriveUninstalling                      = Удаление OneDrive...
OneDriveInstalling                        = OneDrive устанавливается...
OneDriveDownloading                       = Скачивается OneDrive...
OneDriveWarning                           = Функция "{0}" будет применена только в случае, если в пресете настроено удаление OneDrive (или приложение уже удалено), иначе ломается функционал резервного копирования для папок "Рабочий стол" и "Изображения" в OneDrive.
WindowsFeaturesTitle                      = Компоненты Windows
OptionalFeaturesTitle                     = Дополнительные компоненты
EnableHardwareVT                          = Включите виртуализацию в UEFI.
UserShellFolderNotEmpty                   = В папке "{0}" остались файлы. Переместите их вручную в новое расположение.
UserFolderLocationMove                    = Не следует перемещать пользовательские папки в корень диска C.
RetrievingDrivesList                      = Получение списка дисков...
DriveSelect                               = Выберите диск, в корне которого будет создана папка "{0}".
CurrentUserFolderLocation                 = Текущее расположение папки "{0}": "{1}".
UserFolderRequest                         = Хотите изменить расположение папки "{0}"?
UserDefaultFolder                         = Хотите изменить расположение папки "{0}" на значение по умолчанию?
ReservedStorageIsInUse                    = Операция не поддерживается, пока используется зарезервированное хранилище\nПожалуйста, повторно запустите функцию "{0}" после перезагрузки.
ShortcutPinning                           = Ярлык "{0}" закрепляется на начальном экране...
SSDRequired                               = Чтобы использовать подсистему Windows для Android™ на вашем ПК должен быть установлен твердотельный накопитель (SSD).
UninstallUWPForAll                        = Для всех пользователей
UWPAppsTitle                              = UWP-приложения
GraphicsPerformanceTitle                  = Установить для любого приложения по вашему выбору настройки производительности графики на "Высокая производительность"?
ActionCenter                              = Чтобы использовать функцию "{0}" вам необходимо включить центр уведомлений.
WindowsScriptHost                         = На данном компьютере отключен доступ к серверу сценариев Windows. Чтобы использовать функцию "{0}", вам необходимо включить сервер сценариев Windows.
ScheduledTaskPresented                    = Функция "{0}" уже была создана от имени "{1}".
CleanupTaskNotificationTitle              = Очистка Windows
CleanupTaskNotificationEvent              = Запустить задание по очистке неиспользуемых файлов и обновлений Windows?
CleanupTaskDescription                    = Очистка неиспользуемых файлов и обновлений Windows, используя встроенную программу Очистка диска.
CleanupNotificationTaskDescription        = Всплывающее уведомление с напоминанием об очистке неиспользуемых файлов и обновлений Windows.
SoftwareDistributionTaskNotificationEvent = Кэш обновлений Windows успешно удален.
TempTaskNotificationEvent                 = Папка временных файлов успешно очищена.
FolderTaskDescription                     = Очистка папки {0}.
EventViewerCustomViewName                 = Создание процесса
EventViewerCustomViewDescription          = События создания нового процесса и аудит командной строки.
RestartWarning                            = Обязательно перезагрузите ваш ПК.
ErrorsLine                                = Строка
ErrorsMessage                             = Ошибки/предупреждения
DialogBoxOpening                          = Диалоговое окно открывается...
Disable                                   = Отключить
Enable                                    = Включить
UserChoiceWarning                         = Microsoft заблокировала возможность записать в раздел реестра UserChoice для расширения .pdf и протоколов http/https с релизом обновления KB5034765.
AllFilesFilter                            = Все файлы
FolderSelect                              = Выберите папку
FilesWontBeMoved                          = Файлы не будут перенесены.
Install                                   = Установить
NoData                                    = Отсутствуют данные.
NoInternetConnection                      = Отсутствует интернет-соединение.
RestartFunction                           = Пожалуйста, повторно запустите функцию "{0}".
NoResponse                                = Невозможно установить соединение с {0}.
Restore                                   = Восстановить
Run                                       = Запустить
Skipped                                   = Пропущено.
GPOUpdate                                 = Обновление GPO...
TelegramGroupTitle                        = Присоединяйтесь к нашей официальной группе в Telegram.
TelegramChannelTitle                      = Присоединяйтесь к нашему официальному каналу в Telegram.
DiscordChannelTitle                       = Присоединяйтесь к нашему официальному каналу в Discord.
Uninstall                                 = Удалить
'@

# SIG # Begin signature block
# MIIbswYJKoZIhvcNAQcCoIIbpDCCG6ACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCcDBwhAkALxhBd
# Q7NUnhiP1+F0XkmCK9/R4NDLAXbhRqCCFgkwggL8MIIB5KADAgECAhBUm8fhP7ik
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
# DjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCDK3HJWO+wD8MBdlZ7mWaIS
# ODA13rXlyu/SyuCCDWyf4TANBgkqhkiG9w0BAQEFAASCAQBOhlv4GDzplRju4T7+
# vNaDTMfwj9sBfngax6uUE2++zQFe+aFeY+h80pX3rRNwm5IWei0fGNNut9hNkmAQ
# SYXmq5CFJhJyGkcPGZFmsKeKpdnD64kC++UeZc7emJcS2c4W+EuYWsRygZoyGsar
# Bitig1LzbZFmjM2fcAQz7OMXgQdVEQxiFTrHeQ4L3fgITVy1o6nnjfs3C3Q7CEgc
# 8U9OnfeAgB85tyNsMgRgIxE+mDTZZg3gk0tT609rhstVrSGfG3AHHmett0R0CxnH
# 6/uQTD80eMK9phKa6gLHZ6NiBK147r2ny/Q66ArQskoSbqCkn+UySIPqqNfRL+k6
# M/1FoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJAgEBMHcwYzELMAkGA1UEBhMC
# VVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBU
# cnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBDQQIQBUSv85Sd
# CDmmv9s/X+VhFjANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG
# 9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNDEyMjAzNlowLwYJKoZIhvcNAQkE
# MSIEIMZEJZdy1R15ZKpfb20V1RI09jEGwbWjsByiyAEdmLDIMA0GCSqGSIb3DQEB
# AQUABIICAIqHiPdVrkS/RuU3irH57RuHifrBzYb5gOB8EoScLb/IfAQ0B4upnj7W
# eFz7HV5djC/i+aFQgHfO7Xq1OjyjItO+HxRj5IRi07lKjtVJzTZEq86snNwt6b5k
# kyESDbB8Gsg8i4sT1p3eirfJoqHOhSEM56t4z9kFKgHZhUqo26le/jsl7zdMnRNQ
# MjFyGmppcddMOjBCaVdeduCu/0owTapX+bLcEXizq93o1ztkdIn55OrfM71/4cL9
# D1qYKefLa2WqqrrY0dTgDUvvDdx7uJ0GmLN8t8U4raWNIyidenfuGhUsjOz4Ipal
# vsnghCKgCelHrj9IYlLYN0nP/PNNd+RWVLVEUYtXInVC+Etmc3skM5IKbZbC73E0
# Q40ozMdi0hCfuHQ6H7sQ/zEhyCoELl1D42Q1+pZGShWgHrA4chHEzkuqJhQguy0E
# AwffXpwbpHTjcxv0zA9LrCjG94gMsePn/LAb5LtpeRqf1vZeOu0Xa9yT1TZUtORq
# YFBJjpSMmOVrS3p/wDgHj30lblL73r0taJ6rvF99JUd7yASfBG0DxdHyiIdvS+XD
# QHYf8ZiBe3nUs32IoI7ffRpbZgZqIDSI/n/o6jGKPlsi2+sJbwQl3dXLjVdG9gfu
# WnFIbHUXzlJFLhHfBMBvDXKZnKMdpwQXizxduwkcrN69ckl72DNj
# SIG # End signature block
