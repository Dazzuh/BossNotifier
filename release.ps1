$source = "bin\Debug\net472"
$packets = "packets\bin\Debug\net472"
$zip = "BossNotifier-fika.zip"

# Remove old zip if it exists
if (Test-Path $zip) {
    Remove-Item $zip
}

# Create a temp structure for the zip
$temp = Join-Path $env:TEMP "BossNotifierZipTemp"
$pluginDir = Join-Path $temp "BepInEx\plugins\BossNotifier"
if (Test-Path $temp) { Remove-Item $temp -Recurse -Force }
New-Item -ItemType Directory -Path $pluginDir -Force | Out-Null

Copy-Item "$source\BossNotifier.dll" $pluginDir
Copy-Item "$packets\BossNotifier.Fika.dll" $pluginDir

# Create the zip so the DLLs are inside BepInEx/plugins/BossNotifier/ in the zip
Compress-Archive -Path (Join-Path $temp '*') -DestinationPath $zip

# Clean up temp folder
Remove-Item $temp -Recurse -Force
