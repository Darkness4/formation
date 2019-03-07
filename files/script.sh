#!/bin/sh

ANDROID_COMPILE_SDK=28
ANDROID_BUILD_TOOLS=28.0.3
ANDROID_SDK_TOOLS=4333796
FLUTTER_CHANNEL=master

sudo apt-get update \
    && apt-get -y install --no-install-recommends apt-transport-https curl git openjdk-8-jdk lib32stdc++6 unzip \
    && apt-get --purge autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

git clone -b "${FLUTTER_CHANNEL}" https://github.com/flutter/flutter.git /opt/flutter

curl -O "https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip" \
    && mkdir /opt/android-sdk \
    && unzip -qq "sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip" -d /opt/android-sdk \
    && rm "sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip"

mkdir ~/.android \
    && echo 'count=0' > ~/.android/repositories.cfg \
    && yes | sdkmanager --licenses \
    && sdkmanager "tools" \
    "build-tools;${ANDROID_BUILD_TOOLS}" \
    "platforms;android-${ANDROID_COMPILE_SDK}" \
    "platform-tools" > /dev/null \
    && yes | sdkmanager --licenses || echo "Failed" \
    && flutter doctor -v

{
  echo "export PATH=/opt/android-sdk/tools/bin:/opt/android-sdk/platform-tools:/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:\$PATH"
  echo "export ANDROID_HOME = /opt/android-sdk"
  echo "export ANDROID_SDK_ROOT = /opt/android-sdk"
  echo "export ANDROID_SDK_HOME = \$HOME"
  echo "export JAVA_HOME = /usr/lib/jvm/java-8-openjdk-amd64"
  echo "export PATH = \$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin"
} >> ~/.profile
