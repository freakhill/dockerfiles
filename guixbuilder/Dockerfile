# -*- dockerfile-mode -*-
# Image used to build guix packages and load them in other images
# IMAGE NAME: freakhill/guix-builder

FROM ubuntu:bionic

ENV GUIX_VERSION=1.0.1
ENV GUIX_GPGKEY=3CE464558A84FDC69DB40CFB090B11993D9AEBB5

### prepare things to install guix
RUN apt-get -y update && apt-get install -y gnupg wget bsdtar xz-utils netbase
### gpg server is kinda unstable so get it here!
RUN mkdir ~/.gnupg                                      \
        && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf \
        && gpg --keyserver pool.sks-keyservers.net --recv-keys $GUIX_GPGKEY
### download and check
RUN mkdir -p /build/guix                                                                       \
        && cd /build/guix                                                                      \
        && wget https://ftp.gnu.org/gnu/guix/guix-binary-$GUIX_VERSION.x86_64-linux.tar.xz     \
        && wget https://ftp.gnu.org/gnu/guix/guix-binary-$GUIX_VERSION.x86_64-linux.tar.xz.sig
WORKDIR /build/guix
RUN gpg --verify guix-binary-$GUIX_VERSION.x86_64-linux.tar.xz.sig
RUN bsdtar -xf guix-binary-$GUIX_VERSION.x86_64-linux.tar.xz && mv var/guix /var/ && mv gnu /
WORKDIR /
### finish the setup
### this is run from docker hub, so we need full repo paths...
COPY guix-setup.sh /
RUN /guix-setup.sh
COPY guix-firstpull.sh /
RUN /guix-firstpull.sh

### And now the multistage build magic!
COPY pack /bin/pack
RUN chmod +x /bin/pack
