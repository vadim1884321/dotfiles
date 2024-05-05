ConvertFrom-StringData -StringData @'
UnsupportedOSBuild                        = Lo script supporta Windows 11 23H2+.
UpdateWarning                             = La tua build di Windows 11 {0}.{1} non è supportata. Build supportate: {2}+. Eseguire Windows Update e riprovare.
UnsupportedLanguageMode                   = La sessione PowerShell è in esecuzione in modalità lingua limitata.
LoggedInUserNotAdmin                      = L'utente in suo non ha i diritti di amministratore.
UnsupportedPowerShell                     = Stai cercando di eseguire lo script tramite PowerShell {0}.{1}. Esegui lo script nella versione di PowerShell appropriata.
PowerShellx86Warning                      = Si sta cercando di eseguire lo script tramite PowerShell (x86). Eseguire lo script in PowerShell (x64).
UnsupportedHost                           = Lo script non supporta l'esecuzione tramite {0}.
Win10TweakerWarning                       = Probabilmente il tuo sistema operativo è stato infettato tramite una backdoor in Win 10 Tweaker.
TweakerWarning                            = La stabilità del sistema operativo Windows potrebbe essere stata compromessa dall'utilizzo dello {0}. Per sicurezza, reinstallare Windows.
Bin                                       = Non ci sono file nella cartella bin. Per favore, scarica di nuovo l'archivio.
RebootPending                             = Il PC è in attesa di essere riavviato.
UnsupportedRelease                        = Nuova versione trovata.
KeyboardArrows                            = Per selezionare la risposta, utilizzare i tasti freccia "{0}" e "{1}" della tastiera
CustomizationWarning                      = Sono state personalizzate tutte le funzioni nel file di configurazione {0} prima di eseguire Sophia Script?
WindowsComponentBroken                    = {0} rimosso dal sistema.
UpdateDefender                            = Le definizioni di Microsoft Defender non sono aggiornate. Eseguire Windows Update e riprovare.
ControlledFolderAccessDisabled            = l'accesso alle cartelle controllata disattivata.
InitialActionsCheckFailed                 = La funzione "InitialActions" non può essere caricata dal file di preselezione {0}.
ScheduledTasks                            = Attività pianificate
OneDriveUninstalling                      = Disinstallazione di OneDrive...
OneDriveInstalling                        = Installazione di OneDrive...
OneDriveDownloading                       = Download di OneDrive...
OneDriveWarning                           = La funzione "{0}" sarà applicata solo se il preset è configurato per rimuovere OneDrive (o se l'app è già stata rimossa), altrimenti la funzionalità di backup per le cartelle "Desktop" e "Pictures" in OneDrive si interromperà.
WindowsFeaturesTitle                      = Funzionalità di Windows
OptionalFeaturesTitle                     = Caratteristiche opzionali
EnableHardwareVT                          = Abilita virtualizzazione in UEFI.
UserShellFolderNotEmpty                   = Alcuni file rimasti nella cartella "{0}". Spostali manualmente in una nuova posizione.
UserFolderLocationMove                    = Non si dovrebbe modificare la posizione della cartella utente nella radice dell'unità C.
RetrievingDrivesList                      = Recupero lista unità...
DriveSelect                               = Selezionare l'unità all'interno della radice del quale verrà creato la cartella "{0}" .
CurrentUserFolderLocation                 = La posizione attuale della cartella "{0}": "{1}".
UserFolderRequest                         = Volete cambiare la posizione della cartella "{0}"?
UserDefaultFolder                         = Volete cambiare la posizione della cartella "{0}" al valore di default?
ReservedStorageIsInUse                    = Questa operazione non è supportata quando spazio riservato è in uso Si prega di eseguire nuovamente la funzione "{0}" dopo il riavvio del PC.
ShortcutPinning                           = Il collegamento "{0}" è stato bloccato...
SSDRequired                               = Per utilizzare Windows Subsystem for Android™ sul proprio dispositivo, è necessario che sul PC sia installata un'unità a stato solido (SSD).
UninstallUWPForAll                        = Per tutti gli utenti
UWPAppsTitle                              = UWP Apps
GraphicsPerformanceTitle                  = Volete impostare l'impostazione delle prestazioni grafiche di un app di vostra scelta a "Prestazioni elevate"?
ActionCenter                              = Per utilizzare la funzione "{0}" è necessario attivare il Centro operativo.
WindowsScriptHost                         = Accesso a Windows Script Host disabilitato sul computer in uso. Per utilizzare la funzione "{0}" è necessario abilitare Windows Script Host.
ScheduledTaskPresented                    = La funzione "{0}" è già stata creata come "{1}".
CleanupTaskNotificationTitle              = Pulizia di Windows
CleanupTaskNotificationEvent              = Eseguire l'operazione di pulizia dei file inutilizzati e aggiornamenti di Windows?
CleanupTaskDescription                    = Pulizia di Windows e dei file inutilizzati degli aggiornamenti utilizzando l'app built-in ""pulizia disco".
CleanupNotificationTaskDescription        = Pop-up promemoria di pulizia dei file inutilizzati e degli aggiornamenti di Windows.
SoftwareDistributionTaskNotificationEvent = La cache degli aggiornamenti di Windows cancellata con successo.
TempTaskNotificationEvent                 = I file cartella Temp puliti con successo.
FolderTaskDescription                     = Pulizia della cartella "{0}".
EventViewerCustomViewName                 = Creazione del processo
EventViewerCustomViewDescription          = Creazione del processi e degli eventi di controllo della riga di comando.
RestartWarning                            = Assicurarsi di riavviare il PC.
ErrorsLine                                = Linea
ErrorsMessage                             = Errori/avvisi
DialogBoxOpening                          = Visualizzazione della finestra di dialogo...
Disable                                   = Disattivare
Enable                                    = Abilitare
UserChoiceWarning                         = Microsoft ha bloccato l'accesso in scrittura alla chiave UserChoice per l'estensione .pdf e il protocollo http/https con il rilascio della KB5034765.
AllFilesFilter                            = Tutti i file
FolderSelect                              = Selezionare una cartella
FilesWontBeMoved                          = I file non verranno trasferiti.
Install                                   = Installare
NoData                                    = Niente da esposizione.
NoInternetConnection                      = Nessuna connessione Internet.
RestartFunction                           = Si prega di riavviare la funzione "{0}".
NoResponse                                = Non è stato possibile stabilire una connessione con {0}.
Restore                                   = Ristabilire
Run                                       = Eseguire
Skipped                                   = Saltato.
GPOUpdate                                 = Aggiornamento GPO...
TelegramGroupTitle                        = Unisciti al nostro gruppo ufficiale Telegram.
TelegramChannelTitle                      = Unisciti al nostro canale ufficiale di Telegram.
DiscordChannelTitle                       = Unisciti al nostro canale ufficiale di Discord.
Uninstall                                 = Disinstallare
'@

# SIG # Begin signature block
# MIIbswYJKoZIhvcNAQcCoIIbpDCCG6ACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCi1GGuZQOxMpsH
# Vw8eJd4cc7rF9E/4V/eUEqiZsf7t4aCCFgkwggL8MIIB5KADAgECAhBUm8fhP7ik
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
# DjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCBgq5qFGOxViGszJAs3+vIB
# H/gKUrGnf+d4Y7erPBKjsjANBgkqhkiG9w0BAQEFAASCAQB112OUl1ni6IyHPSPR
# 0Mta1KBSiCNzmW9oezdQd1VRi7KPcVncajH9fCvfhDWOne0Qr2jK3kNxOrCBqLNk
# 1/+mEDAbCPu40mc4f1WUNesejNMPt9j++3Ovw4G0kJsTVBRhooXwykFQztvkb8es
# F5ACRxZUdjC//N8ivLH+wunHKkHOT3g54qqz0ImLiOIOini7PMdcb/KtaF5ortgY
# 7cWx9AhJVhG12xZG6k/+IcCxUi8Rl8ce9zNlq/vUcP5GEM+oiuXwE5qsJ9Qkug5Y
# UUK6sOYDY1kfYBilA6HXfo2+4HA4tLjayHOm99ANrAKzrUYfEmnyEFnGPB3SHImS
# mdceoYIDIDCCAxwGCSqGSIb3DQEJBjGCAw0wggMJAgEBMHcwYzELMAkGA1UEBhMC
# VVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBU
# cnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBDQQIQBUSv85Sd
# CDmmv9s/X+VhFjANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG
# 9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNDEyMjAzNlowLwYJKoZIhvcNAQkE
# MSIEIDFJke9XU73NkLDB+cmx8QajaehM1M0Fm+i8jE6pUnNyMA0GCSqGSIb3DQEB
# AQUABIICADImRgjs5HiBiWkXwqT1VYiqPF9I16myI2PJKkQmzpRg2PHbp7GX969l
# VzT4550/9NEgHvwDQkzmo20eyF4lvMccB0V0JZ2ZCzeWX1WW/NeSsA1/K7OAD9kc
# 8DhU7YS0D5H2N9rdPenjeNGIgJ6OVWyMlOOLKsMdqbHYnnis3TaTl2X984ztXpur
# BWJS78u7lG93N/dDl0yZ6Y+TtqRh7JskbavFETrza3oYIsY9Va9ic/LX/keUUcq0
# ij2H3RPSCSHZ0Jb3bOsUuy7BS+FmytvsaxPxedmAR8SYN0Yqtp4V8vBm3UzskAGa
# s5gpRCl5NbYitCIus4culVtDOqOSZc9qtx7KKDL7m1yOlIa+bX7Br8qpmo856pdt
# SoujCRQFsTf402X76dMsKBtT6lH9DFIqk5bc4Nf9nv5m6cEHmHjGTvJ4JpQV4wBW
# Zh03BM7JeC6vl6Ijd/ljN+P6ubhRHsG8xT6ErFqM6QFoGExKOdTPYaCMeLk616Tp
# eHaXrEokMIckcXhxPvCF+HkeujXYCqarHVSFCTU6pMS9dqb/sWuFPd9r9JjDWRX+
# m2nxPJTm6lpKXc9U6j7j1A0WPdurppJAF2/KZ5oBk5E+0zPXHqM2NLwpEAH8ZXEc
# 2/oSC4BBnY/VVtw/mIUqCQZHqyimGh63RcYgJmB7MR8nk8t7HOvn
# SIG # End signature block
