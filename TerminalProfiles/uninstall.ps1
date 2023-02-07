$settings = (Get-Content "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Raw | ConvertFrom-Json)

$settings.profiles.defaults = New-Object PSCustomObject

$settings | ConvertTo-Json -Depth 4 | Out-File "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"