#!/usr/bin/env bash

set -e
set -v

GUIX_PROFILE="`echo ~root`/.config/guix/current"
source $GUIX_PROFILE/etc/profile

guix-daemon --build-users-group=guixbuild --disable-chroot &
guix pull
guix package -u
