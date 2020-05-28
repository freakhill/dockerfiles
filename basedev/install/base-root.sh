#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

# so we get manpages
#echo "y\n" | unminimize -y
unminimize -y

# and now let's go
apt-get update
apt-get upgrade -y

ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata

apt-get install -y apt-utils
apt-get install -y \
        sudo \
        build-essential \
        software-properties-common \
        git-core wget curl coreutils unzip xz-utils \
	locales

locale-gen en_US.UTF-8
locale-gen ja_JP.UTF-8
locale-gen ko_KR.UTF-8
locale-gen fr_FR.UTF-8
locale-gen zh_CN.UTF-8
locale-gen th_TH.UTF-8

