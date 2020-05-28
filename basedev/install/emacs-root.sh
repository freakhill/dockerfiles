#!/usr/bin/env bash

#add-apt-repository ppa:kelleyk/emacs
#apt-get update -y
#apt-get install -y emacs26
service snapd start
snap install emacs --beta --classic
