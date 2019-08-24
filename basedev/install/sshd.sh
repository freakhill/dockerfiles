#!/usr/bin/env bash

set -e

################################################################################
# copy .ssh in proper places and fix rights
cp -r /ssh /home/$THE_USER/.ssh
cp /home/$THE_USER/.ssh/id_rsa.pub /home/$THE_USER/.ssh/authorized_keys
ln -s /home /Users # for macos builds

chown $THE_USER -R /home/$THE_USER
for x in `find /home/$THE_USER/.ssh`
do
    if [ -d "$x" ]; then
        chmod 700 "$x"
    elif [ -f "$x" ]; then
        chmod 600 "$x"
    fi
done

################################################################################
# install and configure openssh
apt-get install -y openssh-server net-tools iproute2
mkdir /var/run/sshd
#echo 'root:screencast' | chpasswd
#sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
#sed -i 's/Port 22/Port 10022/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile
