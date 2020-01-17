#!/usr/bin/env bash

set -e

source $HOME/.bash_profile
cd /install
git clone git@github.com:getzola/zola
cd ./zola
cargo build --release
cp ./target/release/zola $HOME/.local/bin/
