# See https://gist.github.com/greglearns/192a4cc31aef8acdf3190fefa4f124ee

# Run ./update-rust-packages.sh to update pinned version to the most recent one.

# This file defines the source of Rust / cargo's crates registry
#
# buildRustPackage will automatically download dependencies from the registry
# version that we define here. If you're having problems downloading / finding
# a Rust library, try updating this to a newer commit.

{ stdenv, fetchFromGitHub, git, lib }:

let
  pinnedVersion = lib.importJSON ./rust-packages.json;
in stdenv.mkDerivation {
  name = "rustRegistry-${pinnedVersion.rev}";

  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "crates.io-index";
    inherit (pinnedVersion) rev sha256;
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
