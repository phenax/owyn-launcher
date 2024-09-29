{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      androidVersion = "34";
      systemImageType = "google_apis_playstore";
      abiVersion = "x86_64";
      buildToolVersion = "34.0.0";

      shell = { pkgs, system }: let
        jdk = pkgs.jdk17;

        androidComposition = pkgs.androidenv.composeAndroidPackages {
          includeEmulator = true;
          platformVersions = [ androidVersion ];
          abiVersions = [ "x86" abiVersion ];
          systemImageTypes = [ systemImageType ];
          includeSystemImages = true;
          useGoogleAPIs = true;
          buildToolsVersions = [ "30.0.3" buildToolVersion ];
          includeNDK = true;
          ndkVersion = "26.1.10909125";
          cmakeVersions = [ "3.22.1" ];
        };
      in pkgs.mkShell rec {
        buildInputs = [
          pkgs.bun
          pkgs.nodePackages."@tailwindcss/language-server"
          pkgs.nodePackages.typescript
          pkgs.nodePackages.typescript-language-server

          androidComposition.androidsdk
          androidComposition.platform-tools
          jdk

          pkgs.just

          pkgs.libxml2
        ];
        nativeBuildInputs = with pkgs; [ clang ];

        JAVA_HOME = "${jdk.home}";
        ANDROID_JAVA_HOME = JAVA_HOME;
        ANDROID_HOME = "${androidComposition.androidsdk}/libexec/android-sdk";
        ANDROID_AVD_HOME = "/home/imsohexy/.config/.android/avd";

        MY_ANDROID_AVD_PKG = "system-images;android-${androidVersion};${systemImageType};${abiVersion}";

        GRADLE_OPTS =
          "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidComposition.androidsdk}/libexec/android-sdk/build-tools/${buildToolVersion}/aapt2";

        LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
        LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (buildInputs ++ nativeBuildInputs)}";
      };
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              android_sdk.accept_license = true;
              licenseAccepted = true;
              allowUnfree = true;
            };
          };
        in
        {
          devShells.default = shell { inherit pkgs system; };
        });
}
