
android-setup:
  sdkmanager "$MY_ANDROID_AVD_PKG" && \
    avdmanager create avd -n channels -k "$MY_ANDROID_AVD_PKG" --device 26 --force;

emu:
  emulator -gpu swiftshader_indirect @channels 

build:
  bun run react-native build-android --mode release

