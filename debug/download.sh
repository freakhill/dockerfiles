#!/usr/bin/env bash

set -euxo pipefail

DEBUG_IMAGE="freakhill/debug"
DEBUG_IMAGE_SHA=
STORAGE_DIR=

main() {
    pull_latest_image_and_get_sha
    if [ ! -d "$STORAGE_DIR" ]
    then
        pick_storage_dir_and_decompress_image
        rewrite_links_so_it_seems_we_are_mounted_on_slash_debug
    fi
}

pull_latest_image_and_get_sha() {
    docker pull "$DEBUG_IMAGE"
    DEBUG_IMAGE_SHA=$(docker inspect --format='{{index .RepoDigests 0}}' $DEBUG_IMAGE)
    STORAGE_DIR="/tmp/fkdebug-$DEBUG_IMAGE_SHA"
}

pick_storage_dir_and_decompress_image() {
    docker save freakhill/debug -o "$STORAGE_DIR/archive.tar"
    pushd "$STORAGE_DIR"
    tar xf archive.tar
    popd
    ln -s "$STORAGE_DIR" "/tmp/freakhill-debug"
}

rewrite_links_so_it_seems_we_are_mounted_on_slash_debug() {
    for l in "$STORAGE"/links/*
    do
        local target=$(readlink -f "$l")
        ln -s "/debug/$target" "$l"
    done
}

main

# image is downloaded, now call /tmp/freakhill-debug/mount.sh $CONTAINER_ID
# to mount the debug volume on an image
# you can then get into the container and run /debug/install.sh to get
# the utilities in the path of your shell.
