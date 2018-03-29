{rustPlatform, stdenv, fetchFromGitHub}:

with rustPlatform;

buildRustPackage rec {
  name = "hello-${version}";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "BurntSushi";
    repo = "ripgrep";
    rev = "${version}";
    sha256 = "0y5d1n6hkw85jb3rblcxqas2fp82h3nghssa4xqrhqnz25l799pj";
  };

  depsSha256 = "0q68qyl2h6i0qsz82z840myxlnjay8p1w5z7hfyr8fqp7wgwa9cx";
}