#!/usr/bin/env bash

set -euxo pipefail

DATE=$(date +"%d-%m-%Y")

cat "$DATE" > ./DATE
git add DATE
git commit -am "daily"
git tag "$DATE"
git push origin --tags
