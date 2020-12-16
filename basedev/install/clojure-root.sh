#!/usr/bin/env bash

apt-get -y install nodejs npm

curl -O https://download.clojure.org/install/linux-install-1.10.1.754.sh
chmod +x linux-install-1.10.1.754.sh
./linux-install-1.10.1.754.sh

npm install -g shadow-cljs
# install babashka
bash <(curl -s https://raw.githubusercontent.com/borkdude/babashka/master/install)

