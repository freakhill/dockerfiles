#!/usr/bin/env bash

# plank
add-apt-repository -y ppa:mfikes/planck
apt-get -y update
apt-get -y install planck nodejs npm

npm install -g shadow-cljs
npm install -g lumo-cljs

