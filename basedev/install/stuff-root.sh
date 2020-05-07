#!/usr/bin/env bash

set -e

# apt-get update

# python pip...
apt-get install -y software-properties-common
add-apt-repository -y universe
add-apt-repository -y multiverse
add-apt-repository -y restricted
apt-get update
apt-get install -y python2 python-pip python3 python3-pip

apt-get -y install \
        nodejs \
        npm \
        ssh \
        ncdu \
        golang \
        vim \
        tmux \
        mosh \
        stow \
        git-lfs \
	psmisc \
        ack \
        jq \
        fasd \
        graphviz \
        tldr \
        lnav \
        shellcheck \
	libsodium-dev \
        tig \
	liquidprompt

# serverless install fails for now so let's just skip it for now
npm install -g serverless

# vivid, for ls-colors
wget "https://github.com/sharkdp/vivid/releases/download/v0.5.0/vivid_0.5.0_amd64.deb"
dpkg -i vivid_0.5.0_amd64.deb

# used by zola
apt-get install -y libssl-dev libsass-dev pkg-config
# used by inkwell (rust llvm lib)
apt-get install -y llvm-7-dev llvm-7-tools

apt-get -y install openjdk-11-jdk

# Ubuntu 18.04 and various Docker images such as openjdk:9-jdk throw exceptions when
# Java applications use SSL and HTTPS, because Java 9 changed a file format, if you
# create that file from scratch, like Debian / Ubuntu do.
#
# Before applying, run your application with the Java command line parameter
#  java -Djavax.net.ssl.trustStorePassword=changeit ...
# to verify that this workaround is relevant to your particular issue.
#
# The parameter by itself can be used as a workaround, as well.

# 0. First make yourself root with 'sudo bash'.

# 1. Save an empty JKS file with the default 'changeit' password for Java cacerts.
#    Use 'printf' instead of 'echo' for Dockerfile RUN compatibility.
/usr/bin/printf '\xfe\xed\xfe\xed\x00\x00\x00\x02\x00\x00\x00\x00\xe2\x68\x6e\x45\xfb\x43\xdf\xa4\xd9\x92\xdd\x41\xce\xb6\xb2\x1c\x63\x30\xd7\x92' > /etc/ssl/certs/java/cacerts

# 2. Re-add all the CA certs into the previously empty file.
/var/lib/dpkg/info/ca-certificates-java.postinst configure
