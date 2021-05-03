#!/usr/bin/env bash

set -ev

#add-apt-repository ppa:ubuntu-elisp/ppa
#apt-get update -y
#export DEBIAN_FRONTEND=noninteractive
#apt-get install -y emacs-snapshot

apt-get install -y autoconf libgccjit-10-dev libxpm-dev libgif-dev libjansson-dev libgnutls28-dev libharfbuzz-dev libmagickwand-dev texinfo
pushd ~
git clone git://git.savannah.gnu.org/emacs.git
cd emacs
./autogen.sh
./configure --with-native-compilation --with-json --with-imagemagick --with-x-toolkit=no
make -j$(nproc)
make install
popd
rm -fr ~/emacs

