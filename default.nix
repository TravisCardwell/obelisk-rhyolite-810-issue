{ system ? builtins.currentSystem
, obelisk ? import ./.obelisk/impl {
    inherit system;
    iosSdkVersion = "13.2";
    config.android_sdk.accept_license = true;
    terms.security.acme.acceptTerms = true;
    reflex-platform-func = import ./dep/reflex-platform;
    useGHC810 = true;
  }
}:
with obelisk;
project ./. ({ hackGet, pkgs, ... }: {
  android.applicationId = "systems.obsidian.obelisk.examples.minimal";
  android.displayName = "Obelisk Minimal Example";
  ios.bundleIdentifier = "systems.obsidian.obelisk.examples.minimal";
  ios.bundleName = "Obelisk Minimal Example";

  overrides = pkgs.lib.composeExtensions
    ( pkgs.callPackage (hackGet ./dep/rhyolite) {
        inherit pkgs;
        inherit obelisk;
      }
    ).haskellOverrides
    ( self: super:
        with pkgs.haskell.lib;
        {
          beam-core = dontCheck super.beam-core;
          beam-postgres = dontCheck super.beam-postgres;
        }
    );
})
