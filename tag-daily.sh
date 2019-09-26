#!/usr/bin/env bash

set -euxo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DATE=$(date +"%d-%m-%Y")

pushd "$DIR"

cat <<EOF > ./DATE
daily tag for autobuild in docker hub:
$DATE
EOF
git add DATE
git commit -am "daily"
git tag "$DATE"
git push origin --tags
git push

popd
