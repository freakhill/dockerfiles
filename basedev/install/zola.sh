#!/usr/bin/env bash

set -e

source $HOME/.bash_profile
cd /install
git clone --depth 1 --branch v0.13.0 git@github.com:getzola/zola
cd ./zola
cat <<EOF >./Cargo.toml

[patch.crates-io]
lexical-core = {git = 'https://github.com/Gelbpunkt/rust-lexical', branch = 'fix-warnings-and-update-deps'}

EOF
cargo build --release
cp ./target/release/zola $HOME/.local/bin/
