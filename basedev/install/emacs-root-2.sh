#!/usr/bin/env bash

set -ev

apt-get install -y libncurses-dev
pushd ~/emacs
./autogen.sh
./configure --with-native-compilation --with-json --with-imagemagick --with-x-toolkit=no
make -j$(nproc)
make install
popd
rm -fr ~/emacs

