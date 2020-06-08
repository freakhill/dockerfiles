#!/usr/bin/env bash

# for ripgrep-all
apt-get -y install build-essential pandoc poppler-utils ffmpeg
# for zola
apt-get -y install libssl-dev
# for mdcat (for onig-sys crate})
apt-get -y install llvm clang
# for nu
apt-get -y install libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev
