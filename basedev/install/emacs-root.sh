#!/usr/bin/env bash

set -ev

apt-get install -y autoconf libgccjit-10-dev libxpm-dev libgif-dev libjansson-dev libgnutls28-dev libharfbuzz-dev libmagickwand-dev texinfo libncurses-dev

pushd ~
git clone git://git.savannah.gnu.org/emacs.git
popd

pushd ~/emacs
./autogen.sh
./configure --with-native-compilation --with-json --with-imagemagick --with-x-toolkit=no
make -j$(nproc)
make install
popd
rm -fr ~/emacs
