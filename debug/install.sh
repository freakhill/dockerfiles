#!/usr/bin/env bash

set -euxo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

main() {
    check_we_are_mounted_on_slash_debug
    install_path
}

check_we_are_mounted_on_slash_debug() {
    local dir=$(readlink -f "$DIR")
    if [ ! "$dir" = "/debug" ]
    then
        echo "FAIL! DEBUG VOLUME MUST BE MOUNTED ON /debug"
        exit 1
    fi
}

install_path() {
    export PATH="$DIR/debug/bin:$PATH"
    return 0
}

main
