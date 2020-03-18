#!/usr/bin/env bash

set -euxo pipefail

docker build --build-arg ARCH=armhf -t freakhill/guixbuilder:armhf .
docker push freakhill/guixbuilder:armhf

