# -*- dockerfile-mode -*-
# My base dev environment
# IMAGE NAME: freakhill-dev

# this dockerfile is unsafe as fuck!

##################################################

FROM freakhill/guixbuilder:latest AS guixbuilder
RUN pack /opt/guixpack/bin s6 s6-rc s6-dns s6-networking

FROM ubuntu:latest

RUN mkdir /build /install

ENV THE_USER=JP11629
ENV THE_UID=502

# PACKAGES
## BASE
### user
COPY install/user.sh /install
RUN /install/user.sh
### base
COPY install/base.sh /install
RUN /install/base.sh
### sshd
COPY ssh-out-of-git /ssh
COPY install/sshd.sh /install
RUN /install/sshd.sh

## APPS
RUN chown "${THE_USER}" /install
### stuff
COPY install/stuff-root.sh /install
RUN /install/stuff-root.sh
COPY install/stuff.sh /install
RUN su -c "/install/stuff.sh" $THE_USER
### emacs
COPY install/emacs-root.sh /install
RUN /install/emacs-root.sh
### aws rds certificates
COPY install/import-rds-certs.sh /install
RUN /install/import-rds-certs.sh
### clojure stuff
COPY install/clojure-root.sh /install
RUN /install/clojure-root.sh
COPY install/clojure.sh /install
RUN su -c "/install/clojure.sh" $THE_USER
### rust (rustup etc.)
COPY install/rust-root.sh /install
RUN /install/rust-root.sh
COPY install/rust.sh /install
RUN su -c "/install/rust.sh" $THE_USER
# zola
COPY install/zola.sh /install
RUN su -c "/install/zola.sh" $THE_USER

# cache bust!
COPY cachebuster-out-of-git /tmp

### pearl, bash package manager
COPY install/pearl.sh /install
RUN su -c "/install/pearl.sh" $THE_USER

# S6 SERVERS
COPY servers /servers
RUN chown -R root:root /servers && chmod u+w -R /servers

RUN rm -fr /build /install

# Guix packages (s6 included)
COPY --from=guixbuilder /packed.tar.gz /
RUN tar xf /packed.tar.gz && rm /packed.tar.gz

# mount point for dropbox, to share history
RUN mkdir /dropbox
WORKDIR /

CMD ["/opt/guixpack/bin/s6-svscan", "/servers"]

# ssh
EXPOSE 10022/tcp
# mosh
EXPOSE 22000-22099/udp
# SERVS IN DEV
EXPOSE 8000-8100/tcp
