#!/usr/bin/env bash

set -e

mkdir -p /home/$THE_USER
#groupadd -g $THE_UID $THE_USER
useradd $THE_USER \
        -c "my account" \
        -u $THE_UID \
        -g sudo \
        -d /home/$THE_USER \
        -m -s /bin/bash

echo "$THE_USER:123" | chpasswd

mkdir -p /home/$THE_USER
chown $THE_USER:sudo -R /home/$THE_USER
