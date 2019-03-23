Set-Variable ANDROID_COMPILE_SDK 28
Set-Variable ANDROID_BUILD_TOOLS 28.0.3
Set-Variable ANDROID_SDK_TOOLS 4333796
Set-Variable FLUTTER_CHANNEL master
Set-Variable DISQUE C:
$env:Path += ";$env:Path;C:\Program Files\Java\jdk1.8.0_201\bin;$DISQUE\android-sdk\tools\bin;$DISQUE\android-sdk\platform-tools;$DISQUE/flutter/bin;$DISQUE\flutter\bin\cache\dart-sdk\bin"

Set-ExecutionPolicy Bypass -Scope Process -Force;
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install jdk8

git clone -b "${FLUTTER_CHANNEL}" https://github.com/flutter/flutter.git $DISQUE\flutter

Invoke-WebRequest "https://dl.google.com/android/repository/sdk-tools-windows-${ANDROID_SDK_TOOLS}.zip" -OutFile out.zip
mkdir $DISQUE\android-sdk
Expand-Archive out.zip -DestinationPath $DISQUE\android-sdk

mkdir ~/.android
Write-Output 'count=0' > ~/.android/repositories.cfg
sdkmanager --licenses
sdkmanager "tools" "build-tools;${ANDROID_BUILD_TOOLS}" "platforms;android-${ANDROID_COMPILE_SDK}" "platform-tools"
sdkmanager --licenses
flutter doctor -v

[System.Environment]::SetEnvironmentVariable($env:Path, "$env:Path;C:\Program Files\Java\jdk1.8.0_201\bin;$DISQUE\android-sdk\tools\bin;$DISQUE\android-sdk\platform-tools;$DISQUE/flutter/bin;$DISQUE\flutter\bin\cache\dart-sdk\bin", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk1.8.0_201", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", "$DISQUE\android-sdk", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", "$DISQUE\android-sdk", [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable("ANDROID_SDK_HOME", "%HOME%", [System.EnvironmentVariableTarget]::Machine)

refreshenv

