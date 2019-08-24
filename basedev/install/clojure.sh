#!/usr/bin/env bash

# lein
mkdir -p ~/.local/bin
pushd ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > lein
chmod +x lein
./lein
popd

