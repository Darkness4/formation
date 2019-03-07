#!/usr/bin/env bash
# Seulement pour Ubuntu/Debian-based

# Install Android SDK et FlutterSDK (avec PATH vers DartSDK)
sudo apt-get update
sudo apt-get -y install --no-install-recommends apt-transport-https curl git openjdk-8-jdk lib32stdc++6 unzip
sudo apt-get --purge autoremove
sudo apt-get autoclean
sudo rm -rf /var/lib/apt/lists/*

sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_unstable.list > /etc/apt/sources.list.d/dart_unstable.list'
sudo apt-get update
sudo apt-get install dart

git clone https://github.com/flutter/flutter.git /opt/flutter

curl -O "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
mkdir /opt/android-sdk
unzip -qq "sdk-tools-linux-4333796.zip" -d /opt/android-sdk
rm "sdk-tools-linux-4333796.zip"

mkdir ~/.android
echo 'count=0' > ~/.android/repositories.cfg
yes | sdkmanager --licenses
sdkmanager "tools" \
    "platforms;android-28" \
    "build-tools;28.0.3" \
    "platform-tools" \
yes | sdkmanager --licenses || echo "Failed" \
flutter doctor -v

{
    echo "export PATH = \$PATH:/usr/lib/dart/bin"
    echo "export PATH = /opt/android-sdk/tools/bin:/opt/android-sdk/platform-tools:/opt/flutter/bin:\$PATH"
    echo "export ANDROID_HOME = /opt/android-sdk"
    echo "export ANDROID_SDK_ROOT = /opt/android-sdk"
    echo "export ANDROID_SDK_HOME = \$HOME"
    echo "export JAVA_HOME = /usr/lib/jvm/java-8-openjdk-amd64"
    echo "export PATH = \$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin"
} >> ~/.profile

# Emulateur
sdkmanager "emulator"
echo "export PATH = \$ANDROID_HOME/emulator:\$PATH" >> ~/.profile
sdkmanager "system-images;android-22;google_apis;x86"
yes | sdkmanager --licenses
echo "no" | avdmanager  --verbose create avd --force --name "Galaxy Nexus API 22" --device "Galaxy Nexus"  --package "system-images;android-22;google_apis;x86" --tag "google_apis" --abi "x86"

# Run
emulator -avd Galaxy_Nexus_API_22