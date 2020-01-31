#!/usr/bin/env bash

apt-get -y install nodejs npm
# plank
add-apt-repository -y ppa:mfikes/planck
apt-get -y update
# no plank available now for some reason
#apt-get -y install planck

curl -O https://download.clojure.org/install/linux-install-1.10.1.502.sh
chmod +x linux-install-1.10.1.502.sh
./linux-install-1.10.1.502.sh

npm install -g shadow-cljs
npm install -g lumo-cljs
