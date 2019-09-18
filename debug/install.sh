#!/bin/sh

### maybe no env... maybe no bash...

set -euxo pipefail

# the correct following one will not work in sh...
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# all we can do is that...
DIR=$(dirname "$0")

main() {
    link_to_root_path
    install_path_to_env
}


link_to_root_path() {
    mkdir -p /gnu/store
    for repo in "${DIR}/gnu/store"/*
    do
        TARGET=/gnu/store/$(basename "$repo")
        [ ! -e "$TARGET" ] && ln -s "$repo" "$TARGET"
    done
}

install_path_to_env() {
    export PATH="${DIR}/guixbins:${DIR}/staticbins:$PATH"
    return 0
}

main
