#!/usr/bin/env bash

set -e

source $HOME/.bashrc
cd /install
git clone git@github.com:getzola/zola
cd ./zola
cargo build --release
cp ./target/release/zola $HOME/.local/bin/
