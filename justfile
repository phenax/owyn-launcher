
android-setup:
  #!/usr/bin/env sh
  sdkmanager "$MY_ANDROID_AVD_PKG" && \
    avdmanager create avd -n channels -k "$MY_ANDROID_AVD_PKG" --device 26 --force;

emu:
  emulator -gpu swiftshader_indirect @channels 
  # emulator -gpu mode @channels 
