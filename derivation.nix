{pkgs, rustPlatform, stdenv, fetchFromGitHub}:

with rustPlatform;

buildRustPackage rec {
  name = "hello-${version}";
  version = "0.4.0";

  buildInputs = with pkgs; [
      openssl
  ];

  src = ./rust;

  depsSha256 = "";
}