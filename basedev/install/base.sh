#!/usr/bin/env bash

touch $HOME/.bashrc
touch $HOME/.bash_profile

cat >>"$HOME/.bash_profile" << EOF

#####################################
## Base
source "$HOME/.bashrc"
#####################################

EOF

