# See https://gist.github.com/greglearns/192a4cc31aef8acdf3190fefa4f124ee

# Change the `name` and `rev`values to select specific dates/commit-SHAs that will be used to download a specific SHA / date to use for nix rust.

# This file defines the source of Rust / cargo's crates registry
#
# buildRustPackage will automatically download dependencies from the registry
# version that we define here. If you're having problems downloading / finding
# a Rust library, try updating this to a newer commit.

{ stdenv, fetchFromGitHub, git }:

stdenv.mkDerivation {
  name = "rustRegistry-2018-03-28";

  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "crates.io-index";
    rev = "1b48e2eb0db20e5e2a5c2d4c5193fe6eda4a5771";
    sha256 = "0p3vsd2fhfs62pxv9f8xsxmfym96z7abkwpqipnxv9vzwbmhcd0c";
  };
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    # For some reason, cargo doesn't like fetchgit's git repositories, not even
    # if we set leaveDotGit to true, set the fetchgit branch to 'master' and clone
    # the repository (tested with registry rev
    # 965b634156cc5c6f10c7a458392bfd6f27436e7e), failing with the message:
    #
    # "Target OID for the reference doesn't exist on the repository"
    #
    # So we'll just have to create a new git repository from scratch with the
    # contents downloaded with fetchgit...

    mkdir -p $out

    cp -r ./* $out/

    cd $out

    git="${git}/bin/git"

    $git init
    $git config --local user.email "example@example.com"
    $git config --local user.name "example"
    $git add .
    $git commit --quiet -m 'Rust registry commit'

    touch $out/touch . "$out/.cargo-index-lock"
  '';
}
