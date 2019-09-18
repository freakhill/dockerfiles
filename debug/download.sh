#!/usr/bin/env bash

set -euxo pipefail

DEBUG_IMAGE="freakhill/debug"

main() {
    local sha
    docker pull "$DEBUG_IMAGE"
    sha=$(get_image_sha "$DEBUG_IMAGE")
    local storage_dir
    storage_dir=/tmp/$(shortname "$sha")
    if [ ! -d "$storage_dir" ]
    then
        mkdir -p "$storage_dir"
        decompress_image "$DEBUG_IMAGE" "$storage_dir"
        make_link_to_latest "$DEBUG_IMAGE" "$storage_dir"
    fi
}

shortname() {
    local image=$1
    # ':' in path fucks up mount -o bind inside docker sometimes
    # no time nor will to investigate why
    # '/' is removed for the simple reason that we do not want subdirs
    echo "$image" | tr '/:' '-_'
}

get_image_sha() {
    local image="$1"
    docker inspect --format='{{index .RepoDigests 0}}' "$image"
}

decompress_image() {
    local image="$1"
    local dir="$2"
    docker save "$1" | \
        ./undocker.py --ignore-errors --output "$dir"
}

make_link_to_latest() {
    local image="$1"
    local dir="$2"
    local target
    target=$(shortname "$image")
    ln -sf "$dir" "/tmp/$target"
}

main

# image is downloaded, now call /tmp/freakhill-debug/mount.sh $CONTAINER_ID
# to mount the debug volume on an image
# you can then get into the container and run /debug/install.sh to get
# the utilities in the path of your shell.
