#!/usr/bin/env bash

#add-apt-repository ppa:kelleyk/emacs
#apt-get update -y
#apt-get install -y emacs26
apt install snapd
bash -c "snap install emacs --beta --classic"
