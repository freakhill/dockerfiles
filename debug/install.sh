#!/usr/bin/env bash

set -euxo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

main() {
    link_to_root_path
    install_path_to_env
}


link_to_root_path() {
    mkdir -p /gnu/store
    for repo in "${DIR}/gnu/store"/*
    do
        local target
        target=/gnu/store/$(basename "$repo")
        [ ! -e "$target" ] && ln -s "$repo" "$target"
    done
}

install_path_to_env() {
    export PATH="${DIR}/guixbins:${DIR}/staticbins:$PATH"
    return 0
}

main
