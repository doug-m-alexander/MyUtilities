$defaults = Get-Content ".\defaults.json" -Raw | ConvertFrom-Json
$defaults.backgroundImage = @(Get-ChildItem "michael_shillingburg_134780307923_background_waves_large_doubled.gif").FullName

$settings = Get-Content "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Raw | ConvertFrom-Json

$settings.profiles.defaults.backgroundImage = $defaults.backgroundImage
$settings.profiles.defaults.backgroundImageOpacity = $defaults.backgroundImageOpacity

$settings | ConvertTo-Json -Depth 4 | Out-File "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"