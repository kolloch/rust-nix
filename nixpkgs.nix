let
  nixpkgs = import <nixpkgs> {};
  fetchNixpkgs = nixpkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    # Updated to release-17.09 as of 2018-03-29
    rev = "3410d73b2012aa429981d598993e0210cb68beb1";
    sha256 = "16h1m2myjlzm320m71w7bk958graxlbvhq5rxrx9gv1vaawwcw8g";
  };
  moz_overlay = import (
    builtins.fetchTarball 
      https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz );
  in (import fetchNixpkgs { 
    config = {};
    overlays = [
      moz_overlay
    ];
  })