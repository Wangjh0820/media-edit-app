$env:ANDROID_HOME = "C:\Android\Sdk"
$env:ANDROID_SDK_ROOT = "C:\Android\Sdk"
$env:Path += ";$env:ANDROID_HOME\cmdline-tools\latest\bin"

$sdkmanager = "C:\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat"

# Accept all licenses
$licenses = @("y", "y", "y", "y", "y", "y", "y", "y", "y", "y")
$licenses -join "`n" | & $sdkmanager --licenses 2>&1 | Out-Null

# Install required components
Write-Host "Installing Android SDK components..."
& $sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

Write-Host "Done!"
