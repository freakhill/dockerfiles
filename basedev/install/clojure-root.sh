#!/usr/bin/env bash

apt-get -y install nodejs npm
# plank
add-apt-repository -y ppa:mfikes/planck
apt-get -y update
# no plank available now for some reason
#apt-get -y install planck

npm install -g shadow-cljs
npm install -g lumo-cljs

