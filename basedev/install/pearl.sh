#!/usr/bin/env bash

set -e

# just installs pearl
cd $HOME
wget https://raw.githubusercontent.com/pearl-core/installer/master/install.sh
bash install.sh # alreads adds pearl to bashrc
rm install.sh

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
