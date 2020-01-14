#!/usr/bin/env bash

set -e

apt-get update
apt-get upgrade -y

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

