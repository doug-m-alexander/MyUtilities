
# Setup defaults with correct location for image
$defaults = Get-Content ".\defaults.json" -Raw | ConvertFrom-Json
$defaults.backgroundImage = @(Get-ChildItem "michael_shillingburg_134780307923_background_waves_large_doubled.gif").FullName

$settings = (Get-Content "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Raw | ConvertFrom-Json)

$defaultProperties = @(Get-Member -inputobject $defaults -Membertype NoteProperty)
$existingProperties = @(Get-Member -InputObject $settings.profiles.defaults -Membertype NoteProperty).Name

foreach($property in $defaultProperties)
{
    Write-Debug $property.Name
    if($null -ne $existingProperties -and $existingProperties.contains($property.Name))
    {
        $settings.profiles.defaults = $defaults.($property.Name)
    }
    else 
    {
        Add-Member -InputObject $settings.profiles.defaults -NotePropertyName $property.Name -NotePropertyValue $defaults.($property.Name)
    }
}

$settings.profiles.defaults.backgroundImage = $defaults.backgroundImage
$settings.profiles.defaults.backgroundImageOpacity = $defaults.backgroundImageOpacity

$settings | ConvertTo-Json -Depth 4 | Out-File "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"