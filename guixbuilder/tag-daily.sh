#!/usr/bin/env bash

set -euxo pipefail

DATE=$(date +"%d-%m-%Y")

cat ./DATE <<EOF
daily tag for autobuild in docker hub:
$DATE
EOF
git add DATE
git commit -am "daily"
git tag "$DATE"
git push origin --tags
