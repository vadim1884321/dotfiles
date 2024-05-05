ConvertFrom-StringData -StringData @'
UnsupportedOSBuild                        = Le script prend en charge Windows 11 23H2+.
UpdateWarning                             = Votre version de Windows 11 : {0}.{1}. Versions prises en charge: {2}+. Exécutez Windows Update et réessayez.
UnsupportedLanguageMode                   = La session PowerShell s'exécute dans un mode de langue limité.
LoggedInUserNotAdmin                      = L'utilisateur connecté n'a pas de droits d'administrateur.
UnsupportedPowerShell                     = Vous essayez d'exécuter le script via PowerShell {0}.{1}. Exécutez le script dans la version appropriée de PowerShell.
PowerShellx86Warning                      = Vous essayez d'exécuter le script via PowerShell (x86). Exécutez le script dans PowerShell (x64).
UnsupportedHost                           = Le script ne supporte pas l'exécution via {0}.
Win10TweakerWarning                       = Votre système d'exploitation a probablement été infecté par la porte dérobée Win 10 Tweaker.
TweakerWarning                            = La stabilité de l'OS Windows peut avoir été compromise par l'utilisation du {0}. Au cas où, réinstallez Windows.
Bin                                       = Il n'y a pas de fichiers dans le dossier bin. Veuillez retélécharger l'archive.
RebootPending                             = Le PC attend d'être redémarré.
UnsupportedRelease                        = Nouvelle version trouvée.
KeyboardArrows                            = Veuillez utiliser les touches fléchées {0} et {1} de votre clavier pour sélectionner votre réponse
CustomizationWarning                      = Avez-vous personnalisé chaque fonction du fichier de préréglage {0} avant d'exécuter Sophia Script?
WindowsComponentBroken                    = {0} cassé ou supprimé du système d'exploitation.
UpdateDefender                            = Les définitions de Microsoft Defender ne sont pas à jour. Exécutez Windows Update et réessayez.
ControlledFolderAccessDisabled            = Contrôle d'accès aux dossiers désactivé.
InitialActionsCheckFailed                 = La fonction "InitialActions" ne peut pas être chargée à partir du fichier de présélection {0}.
ScheduledTasks                            = Tâches planifiées
OneDriveUninstalling                      = Désinstalltion de OneDrive...
OneDriveInstalling                        = Installation de OneDrive...
OneDriveDownloading                       = Téléchargement de OneDrive...
OneDriveWarning                           = La fonction "{0}" sera appliquée uniquement si le préréglage est configuré pour supprimer OneDrive (ou si l'application a déjà été supprimée), sinon la fonctionnalité de sauvegarde des dossiers "Desktop" et "Pictures" dans OneDrive s'interrompt.
WindowsFeaturesTitle                      = Fonctionnalités
OptionalFeaturesTitle                     = Fonctionnalités optionnelles
EnableHardwareVT                          = Activer la virtualisation dans UEFI.
UserShellFolderNotEmpty                   = Certains fichiers laissés dans le dossier "{0}". Déplacer les manuellement vers un nouvel emplacement.
UserFolderLocationMove                    = Vous ne devez pas changer l'emplacement du dossier de l'utilisateur pour la racine du lecteur C.
RetrievingDrivesList                      = Récupération de la liste des lecteurs...
DriveSelect                               = Sélectionnez le disque à la racine dans lequel le dossier "{0}" sera créé.
CurrentUserFolderLocation                 = L'emplacement actuel du dossier "{0}": "{1}".
UserFolderRequest                         = Voulez vous changer où est placé le dossier "{0}" ?
UserDefaultFolder                         = Voulez vous changer où est placé le dossier "{0}" à sa valeur par défaut?
ReservedStorageIsInUse                    = Cette opération n'est pas suppportée le stockage réservé est en cours d'utilisation\nVeuillez réexécuter la fonction "{0}" après le redémarrage du PC.
ShortcutPinning                           = Le raccourci "{0}" est épinglé sur Démarrer...
SSDRequired                               = Pour utiliser le sous-système Windows pour Android™ sur votre appareil, votre PC doit être équipé d'un lecteur à état solide (SSD).
UninstallUWPForAll                        = Pour tous les utilisateurs
UWPAppsTitle                              = Applications UWP
GraphicsPerformanceTitle                  = Souhaitez-vous définir le paramètre de performances graphiques d'une application de votre choix sur "Haute performance"?
ActionCenter                              = Pour utiliser la fonction "{0}", vous devez activer le Centre d'action.
WindowsScriptHost                         = L'accès à Windows Script Host est désactivé sur cette machine. Pour utiliser la fonction "{0}", vous devez activer Windows Script Host.
ScheduledTaskPresented                    = La fonction "{0}" a déjà été créée en tant que "{1}".
CleanupTaskNotificationTitle              = Nettoyer Windows
CleanupTaskNotificationEvent              = Exécuter la tâche pour nettoyer les fichiers et les mises à jour inutilisés de Windows?
CleanupTaskDescription                    = Nettoyage des fichiers Windows inutilisés et des mises à jour à l'aide de l'application intégrée pour le nettoyage de disque.
CleanupNotificationTaskDescription        = Rappel de notification contextuelle sur le nettoyage des fichiers et des mises à jour inutilisés de Windows.
SoftwareDistributionTaskNotificationEvent = Le cache de mise à jour Windows a bien été supprimé.
TempTaskNotificationEvent                 = Le dossier des fichiers temporaires a été nettoyé avec succès.
FolderTaskDescription                     = Nettoyage du dossier "{0}".
EventViewerCustomViewName                 = Création du processus
EventViewerCustomViewDescription          = Audit des événements de création du processus et de ligne de commande.
RestartWarning                            = Assurez-vous de redémarrer votre PC.
ErrorsLine                                = Ligne
ErrorsMessage                             = Erreurs/Avertissements
DialogBoxOpening                          = Afficher la boîte de dialogue...
Disable                                   = Désactiver
Enable                                    = Activer
UserChoiceWarning                         = Microsoft a bloqué l'accès en écriture à la clé UserChoice pour l'extension .pdf et le protocole http/https avec la version KB5034765.
AllFilesFilter                            = Tous les Fichiers
FolderSelect                              = Sélectionner un dossier
FilesWontBeMoved                          = Les fichiers ne seront pas déplacés.
Install                                   = Installer
NoData                                    = Rien à afficher.
NoInternetConnection                      = Pas de connexion Internet.
RestartFunction                           = Veuillez redémarrer la fonction "{0}".
NoResponse                                = Une connexion n'a pas pu être établie avec {0}.
Restore                                   = Restaurer
Run                                       = Démarrer
Skipped                                   = Passé.
GPOUpdate                                 = Mise à jour de la GPO...
TelegramGroupTitle                        = Rejoignez notre groupe Telegram officiel.
TelegramChannelTitle                      = Rejoignez notre canal Telegram officiel.
DiscordChannelTitle                       = Rejoignez notre canal Discord officiel.
Uninstall                                 = Désinstaller
'@

# SIG # Begin signature block
# MIIbswYJKoZIhvcNAQcCoIIbpDCCG6ACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDwpLtp1ykuVVlm
# y8MDi9rXEYBVKVDOlSk0Secr+7gSUKCCFgkwggL8MIIB5KADAgECAhBUm8fhP7ik
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
# DjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCDjrbaLVdU6iYp5j2LVxwWM
# Q1MFFQIFvJ7uKmdy1LcRWzANBgkqhkiG9w0BAQEFAASCAQA0WKJ1S/QJ9fT7Cl1I
# AN612ss0QcMTw8J+Vogdcxt2EZFmoEtZIyshGYCrwn3Sw1y91ntSUT6DV3Q0o2wP
# BChZ97W7ZG1WPeI/o4GfZNSAmHraQEMGRCchsiG3zVI7MvFnAExpzFk3RZsRs2Z9
# iTPC6Nrbx6SdMEys9gNlyLcDte99LXL7yrHGEx7SvCQhtSAZgk9eWAoNfHhjx1u5
# RBglnNj/IPbThxq34MN7NoD5TxsjYpDO3h+yV1erkVOzbJuByPPWGQpghDie3M+v
# gPM86JSZbtGc+rgE8lNNingIZuqHL/p8021v7Qd9s6txfnIIffMZ8NooEZ0hYG8/
# O4IKoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJAgEBMHcwYzELMAkGA1UEBhMC
# VVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBU
# cnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBDQQIQBUSv85Sd
# CDmmv9s/X+VhFjANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG
# 9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNDEyMjAzNlowLwYJKoZIhvcNAQkE
# MSIEIFn1kt06shcA4kzvux2JegrlUqKZg/rBge0IxmPwIvv5MA0GCSqGSIb3DQEB
# AQUABIICAH8tz0C6K7ksTNKDfVx/B2B9BqlxQojSe7GD9AwBYpNjWYgrF1dwqzvm
# HJrGr3MHrGqVS5F89Rp/nJMFTVKGFOtSi/lAoOlcClb/648yePmFew8st+/2JAQx
# qKNFAKKfz4g/OCrwhJOJGx1lSYyrGrQXOtKtYCyw/O5bj2uz36YYU/EvMpl4BiVS
# JzzFGcR8nXogBHoVWERhYx/+nm2Tdykg0oKKpHBOt/v+xr4Va3L0Wvq+f1H9bSAK
# 5A+RtmB76UoJyv2Gdm0IgRa1sHSxMCxXDnqTkiksz90yGYkXuL5INjWNVrhXaiZg
# DBtW+X8+P842Rz0W5+SxJ7QxEikDyMZYCfAyi5kUw7V5fT/PVkrDEU2nOQ7eYXlW
# zlcREyZrQXF48yT3HMFhelheYHsI4a/xeVlj8c5FA5DQCwDbebHV+qUHTenAF295
# ilMgoVpWNVXSsESmPF88bV2tRZvD94CAd/DYcYRzD9LCtX+pbXP0a3ykC4Lq9z3X
# Km9Cq6LetZkxjQMKGFZ2hJ8F09xzN9QFqImcwdwwMi2wvxVZD0lWpyOL3ixUbP+W
# rBAum9rwzQXGjTxXRtFLN8JklccZyOrQIacuP2XlwiFHqrSnAmpz0kWNXAJKVyax
# Lxi5i21uwYdTCusXzonZ/Ygb2p//f169XS/NQrnXW8L63w5dg2A0
# SIG # End signature block
