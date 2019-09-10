# -*- dockerfile-mode -*-
# Image which contains stuff
# we decompress this image, and live bind mount the resulting folder
# in the container we want to debug!
# IMAGE NAME: debug

FROM freakhill/guixbuilder:latest AS guixbuilder
RUN pack /links \
        less more vim emacs-nox curl wget ncdu netcat stow
### TODO: create a recipe to build lnav
### or download directly from
### https://github.com/tstack/lnav/releases/download/v0.8.5/lnav-0.8.5-linux-64bit.zip

FROM alpine:latest

WORKDIR /

COPY --from=guixbuilder /packed.tar.gz /
RUN tar xf /packed.tar.gz && rm /packed.tar.gz

# run on the host to mount the volume to a running container
ADD debug/mount.sh /
# run on the host to unmount the volume in the running container
ADD debug/unmount.sh /
# run inside the running container to get everything running well in your shell
ADD debug/install.sh /

# not needed, just added for reference, it's the script to download this
# image, decompress it, and prepare it to get the generated directory
# mounted on containers.
ADD debug/download.sh /
