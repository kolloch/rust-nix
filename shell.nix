let
  nixpkgs = import ./nixpkgs.nix;
in
  with nixpkgs;
  stdenv.mkDerivation {
    name = "moz_overlay_shell";
    buildInputs = [
      nixpkgs.latest.rustChannels.nightly.rust
      ];
  }