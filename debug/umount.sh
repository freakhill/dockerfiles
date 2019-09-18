#!/usr/bin/env bash

set -euxo pipefail

TMP_MNT_DIR=/__temporary_mount

main() {
    local container_name_or_id="$1"
    local container_pid
    container_pid=$(get_container_pid "$container_name_or_id")
    unmount "$container_pid"
}

unmount() {
    local container_pid="$1"
    in_container_ns "$container_pid" umount "$TMP_MNT_DIR"
    in_container_ns "$container_pid" rmdir "$TMP_MNT_DIR"
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

main "${@}"
