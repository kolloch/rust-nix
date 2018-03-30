#!/usr/bin/env bash

nix-prefetch-git \
    https://github.com/rust-lang/crates.io-index \
    > rust-packages.json