install_flutter() {
  git clone -b stable https://github.com/flutter/flutter.git

  flutter precache
  yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
  flutter doctor
}

launch_avd() {
  echo "Installing SDK"
  $ANDROID_HOME/tools/bin/sdkmanager --install 'system-images;android-29;default;x86'

  echo "Creating emulator"
  $ANDROID_HOME/tools/bin/avdmanager create avd -n "pixel" --device "pixel" -k "system-images;android-29;default;x86"

  echo "Starting emulator"
  $ANDROID_HOME/emulator/emulator -avd "pixel" -no-snapshot &
  $ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'

  echo "Emulator started"
}

build_app() {
    flutter pub get
}

flutter_integration_test() {
    flutter test integration_test
}