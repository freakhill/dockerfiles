#!/usr/bin/env bash

set -eux

# just installs pearl
cd $HOME
pip3 install --user pearlcli
export PATH=$PATH:$HOME/.local/bin
pearl init

cat <<EOF >> $HOME/.config/pearl/pearl.conf

####################################################
# my custom packages

PEARL_PACKAGES["freakhill-stuff"]="https://github.com/freakhill/dotfiles.git"
PEARL_PACKAGES_DESCR["freakhill-stuff"]="generic stuff bundled together"

PEARL_PACKAGES["freakhill-emacs"]="https://github.com/freakhill/dotemacs.git"
PEARL_PACKAGES_DESCR["freakhill-emacs"]="my emacs conf"

PEARL_PACKAGES["freakhill-guix"]="https://github.com/freakhill/dotguix.git"
PEARL_PACKAGES_DESCR["freakhill-guix"]="my guix recipes and stuff to update/install"
EOF

bash -c "source ~/.bashrc; pearl install freakhill-emacs freakhill-stuff"

