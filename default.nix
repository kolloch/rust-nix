{ nixpkgs? import <nixpkgs> {} }:

let
  fetchNixpkgs = nixpkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    #branch = "17.09";
    rev = "2a28e657421be06a0f2b1189344f454e12d0e2f7";
    sha256 = "0vjjdkplkak7vd6pjyvi89ib2rfd00gbqfpwkp0jwckqa61gfx5x";
  };
  pkgs = import fetchNixpkgs { config = {}; };
in pkgs.callPackage ./derivation.nix {}