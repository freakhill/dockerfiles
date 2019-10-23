# -*- dockerfile-mode -*-
# Image which contains stuff
# we decompress this image, and live bind mount the resulting folder
# in the container we want to debug!
# IMAGE NAME: debug

FROM freakhill/guixbuilder:daily-24-10-2019 AS guixbuilder
RUN pack /guixbins \
        bash less vim emacs curl wget ncdu netcat unzip tar bzip2

FROM alpine:3

WORKDIR /

### packed with guix
COPY --from=guixbuilder /packed.tar.gz /
RUN tar xf /packed.tar.gz && rm /packed.tar.gz

### directory for static binaries
RUN mkdir -p /staticbins

### we add static binaries we want
RUN apk add wget unzip
RUN wget https://github.com/tstack/lnav/releases/download/v0.8.5/lnav-0.8.5-linux-64bit.zip
RUN unzip lnav-0.8.5-linux-64bit.zip
RUN cp lnav-0.8.5/lnav /staticbins/

# run on the host to mount the volume to a running container
ADD mount.sh /
# run on the host to unmount the volume in the running container
ADD umount.sh /
# run inside the running container to get everything running well in a new shell
ADD bash /

# not needed, just added for reference, it's the script to download this
# image, decompress it, and prepare it to get the generated directory
# mounted on containers.
ADD download.sh /
