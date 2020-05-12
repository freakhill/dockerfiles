#!/usr/bin/env bash

# lein
mkdir -p ~/.local/bin
pushd ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > lein
chmod +x lein
./lein
popd

pushd ~/.local/bin
curl -fsSL https://github.com/hypirion/inlein/releases/latest > inlein
chmod +x inlein
popd


pushd ~/.local/bin
BB=babashka-0.0.78-linux-static-amd64.zip
wget https://github.com/borkdude/babashka/releases/download/v0.0.78/$BB
unzip $BB
rm $BB
popd

pushd ~/.local/bin
wget https://github.com/snoe/clojure-lsp/releases/download/release-20200511T135432/clojure-lsp
chmod 755 clojure-lsp
popd
