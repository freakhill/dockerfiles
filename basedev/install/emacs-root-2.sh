#!/usr/bin/env bash

set -ev

pushd ~/emacs
./autogen.sh
./configure --with-native-compilation --with-json --with-imagemagick --with-x-toolkit=no
make -j$(nproc)
make install
popd
rm -fr ~/emacs

