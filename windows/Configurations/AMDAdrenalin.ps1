$repo = "nunodxxd/AMD-Software-Adrenalin"
$tag = (Invoke-WebRequest -Uri "https://api.github.com/repos/$repo/releases" -UseBasicParsing | ConvertFrom-Json)

Write-Host $tag
