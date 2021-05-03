#!/usr/bin/env bash

set -ev

apt-get install -y autoconf libgccjit-10-dev libxpm-dev libgif-dev libjansson-dev libgnutls28-dev libharfbuzz-dev libmagickwand-dev texinfo

pushd ~
git clone git://git.savannah.gnu.org/emacs.git
popd

