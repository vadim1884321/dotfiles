# Enable script logging. The log will be being recorded into the script root folder
# To stop logging just close the console or type "Stop-Transcript"
function Logging
{
	$TranscriptFilename = "Log-$((Get-Date).ToString("dd.MM.yyyy-HH-mm"))"
	Start-Transcript -Path $PSScriptRoot\..\$TranscriptFilename.txt -Force
}
