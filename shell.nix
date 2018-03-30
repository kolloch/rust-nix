let
  nixpkgs = import ./nixpkgs.nix;
in
  with nixpkgs;
  stdenv.mkDerivation {
    name = "moz_overlay_shell";
    RUST_SRC_PATH = "${rust}/lib/rustlib/src/rust/src";
    buildInputs = [
        rust
      ];
  }