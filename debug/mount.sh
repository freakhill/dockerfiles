#!/usr/bin/env bash

set -euxo pipefail

TMP_MNT_DIR=/__temporary_mount

################################################################################
# Objective:
# mount $3 to $2 in container $1
# Example:
# mount.sh mycontainer /debug /dir_in_host
################################################################################
# heavily inspired by:
# https://jpetazzo.github.io/2015/01/13/docker-mount-dynamic-volumes/
# https://medium.com/kokster/mount-volumes-into-a-running-container-65a967bee3b5
################################################################################

main() {
    local container_name_or_id="$1"
    local path_in_container="${2:-/debug}"
    local dir="${3:-$( cd "$( canondirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )}"
    ###
    local canondir
    local filesystem
    local dev
    local dev_mknod_encoding
    local subroot
    local container_pid
    canondir=$(readlink --canonicalize "$dir")
    filesystem=$(get_filesystem "$canondir")
    dev=$(get_device "$filesystem")
    dev_mknod_encoding=$(get_device_mknod_encoding "$dev")
    subroot=$(get_subroot "$filesystem")
    container_pid=$(get_container_pid "$container_name_or_id")
    mount "$container_pid" "$filesystem" "$canondir" "$dev" "$dev_mknod_encoding" \
          "$path_in_container" "$subroot"
}

get_filesystem() {
    local canondir="$1"
    df -P "$canondir" | tail -n 1 | awk '{print $6}'
}

get_device() {
    local filesys="$1"
    local dev
    local mount
    local junk
    while read -r dev mount junk
    do
        [ "$mount" = "$filesys" ] && break
    done </proc/mounts
    [ "$mount" = "$filesys" ] || exit 1
    echo "$dev"
}

get_device_mknod_encoding() {
    local dev="$1"
    local block_dev
    block_dev=$(printf "%d %d" $(stat --format "0x%t 0x%T" "$dev"))
    if [ "$block_dev" = "0 0" ]
    then
        # maybe it is a block device
        printf "%d %d" $(lsblk -n "$dev" | cut -f2 -d' ' | sed 's/:/ /')
        return 0
    else
        # we good!
        echo "$block_dev"
    fi
}

get_subroot() {
    local filesys="$1"
    local junk
    local subroot
    while read -r junk junk junk subroot mount junk
    do
        [ "$mount" = "$filesys" ] && break
    done < /proc/self/mountinfo
    [ "$mount" = "$filesys" ] || exit 1
    echo "$subroot"
}

get_container_pid() {
    local container_name_or_id="$1"
    docker inspect --format '{{.State.Pid}}' "$container_name_or_id"
}

in_container_ns() {
    local container_pid="$1"
    shift
    nsenter --target "$container_pid" --mount --uts --ipc --net --pid -- "${@}"
}

mount() {
    local container_pid="$1"
    local filesystem="$2"
    local canondir="$3"
    local dev="$4"
    local dev_mknod_encoding="$5"
    local path_in_container="$6"
    local subroot="$7"

    local subpath
    subpath=$(realpath --relative-to "$filesystem" "$canondir")

    in_container_ns "$container_pid" sh -c "umask 0600 && mkdir -p $(dirname $dev)"
    in_container_ns "$container_pid" sh -c "[ -b $dev ] || mknod -m 0600 $dev b $dev_mknod_encoding"
    in_container_ns "$container_pid" mkdir "$TMP_MNT_DIR"
    in_container_ns "$container_pid" mount "$dev" "$TMP_MNT_DIR"
    in_container_ns "$container_pid" mkdir -p "$path_in_container"
    in_container_ns "$container_pid" mount -o bind "$TMP_MNT_DIR/$subroot/$subpath" "$path_in_container"
}

if [ "$*" = "test-shell" ]
then
    export -f in_container_ns
    export -f get_filesystem
    export -f get_device
    export -f get_device_mknod_encoding
    export -f get_subroot
    export -f get_container_pid
    bash
else
    main "${@}"
fi
