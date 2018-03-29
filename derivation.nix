{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, pkgs, cacert }:

with rustPlatform;

# from https://github.com/NixOS/nixpkgs/issues/23282
rec {
   hello = stdenv.mkDerivation rec {
      name = "rust";
      src = ./rust;
      buildInputs = with pkgs; [ rustc cargo openssl ];
      postUnpack = ''
      mkdir -p $sourceRoot/.cargo
      cat <<EOF > $sourceRoot/.cargo/config # FIXME
[source.crates-io]
replace-with = "nix-store-rust-registry"

[source.nix-store-rust-registry]
registry = "file://${pkgs.rustPlatform.rustRegistry}"
EOF
      export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
      export CARGO_HOME=$sourceRoot/.cargo
      mkdir -p $CARGO_HOME
      cd $sourceRoot
      cargo fetch --locked --verbose
      cargo clean
      cd ..
      rm -Rf $sourceRoot/.cargo/registry/index/*/.git
      find . -exec touch --date=@$SOURCE_DATE_EPOCH {} \;
      '';

      buildPhase = ''
       export CARGO_HOME=$sourceRoot/.cargo
       cargo build --frozen --release
      '';
      installPhase = ''
         install -m 755 -d $out/bin
         install -m 755 target/release/nix-rust $out/bin
      '';
   };
}