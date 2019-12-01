#!/usr/bin/env bash

# for ripgrep-all
apt -y install build-essential pandoc poppler-utils ffmpeg
# for zola
apt -y install libssl-dev
# for mdcat (for onig-sys crate})
apt-get -y install llvm clang

