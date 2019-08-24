#!/usr/bin/env bash

set -e
set -v

mkdir -p /build/guix
cd /build/guix

wget https://ftp.gnu.org/gnu/guix/guix-binary-1.0.1.x86_64-linux.tar.xz
wget https://ftp.gnu.org/gnu/guix/guix-binary-1.0.1.x86_64-linux.tar.xz.sig

mkdir ~/.gnupg
echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf
gpg --keyserver pool.sks-keyservers.net --recv-keys 3CE464558A84FDC69DB40CFB090B11993D9AEBB5

gpg --verify guix-binary-1.0.1.x86_64-linux.tar.xz.sig

tar --warning=no-timestamp -xf \
    guix-binary-1.0.1.x86_64-linux.tar.xz
mv var/guix /var/ && mv gnu /

mkdir -p ~root/.config/guix
ln -sf /var/guix/profiles/per-user/root/current-guix ~root/.config/guix/current

GUIX_PROFILE="`echo ~root`/.config/guix/current"
source $GUIX_PROFILE/etc/profile

groupadd --system guixbuild

for i in `seq -w 1 42`;
  do
    useradd -g guixbuild -G guixbuild           \
            -d /var/empty -s `which nologin`    \
            -c "Guix build user $i" --system    \
            guixbuilder$i;
  done

mkdir -p /usr/local/bin
cd /usr/local/bin
ln -s /var/guix/profiles/per-user/root/current-guix/bin/guix

mkdir -p /usr/local/share/info
cd /usr/local/share/info
for i in /var/guix/profiles/per-user/root/current-guix/share/info/*
do
  ln -s $i
done

guix archive --authorize < ~root/.config/guix/current/share/guix/ci.guix.info.pub

touch /home/$THE_USER/.bashrc
chown $THE_USER /home/$THE_USER/.bashrc

cat <<EOF >> /home/$THE_USER/.bashrc

####################################################
# from install/guix.sh
export GUIX_LOCPATH=\$HOME/.guix-profile/lib/locale
####################################################

EOF

cat <<EOF >> /root/.bashrc

####################################################
# from install/guix.sh
GUIX_PROFILE="`echo ~root`/.config/guix/current"
source $GUIX_PROFILE/etc/profile
####################################################

EOF

