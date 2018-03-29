{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper }:

with rustPlatform;

buildRustPackage rec {
  name = "stuff-${version}";
  version = "0.1.0";

  src = ./rust;

  depsSha256 = "08k3w8c637kzcq1r3k62c5hvrig5bgxb932k9gzn2ixb8if3jk0j";

  preFixup = ''
  '';
}