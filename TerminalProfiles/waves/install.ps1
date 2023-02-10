$curr = pwd
$mypath = $MyInvocation.MyCommand.Path
cd $mypath.TrimEnd($MyInvocation.MyCommand.Name)

# Setup defaults with correct location for image
$defaults = Get-Content ".\defaults.json" -Raw | ConvertFrom-Json
$defaults.backgroundImage = @(Get-ChildItem "michael_shillingburg_134780307923_background_waves_large_doubled.gif").FullName

$settings = (Get-Content "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Raw | ConvertFrom-Json)

$defaultProperties = @(Get-Member -inputobject $defaults -Membertype NoteProperty)
$existingProperties = @(Get-Member -InputObject $settings.profiles.defaults -Membertype NoteProperty).Name

foreach($property in $defaultProperties)
{
    if($null -ne $existingProperties -and $existingProperties.contains($property.Name))
    {
        $settings.profiles.defaults.($property.Name) = $defaults.($property.Name)
    }
    else 
    {
        Add-Member -InputObject $settings.profiles.defaults -NotePropertyName $property.Name -NotePropertyValue $defaults.($property.Name)
    }
}

$settings | ConvertTo-Json -Depth 10 | Out-File "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

cd $curr