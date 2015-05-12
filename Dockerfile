FROM debian:jessie
MAINTAINER Nathan Handler <nathan.handler@gmail.com>

ENV ARCH amd64
ENV DIST stable
ENV MIRROR http://http.debian.net

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y \
    dnsmasq \
    iptables \
    wget

RUN mkdir -p /srv/tftp
WORKDIR /srv/tftp

RUN wget $MIRROR/debian/dists/$DIST/main/installer-$ARCH/current/images/netboot/netboot.tar.gz
RUN tar xvzf netboot.tar.gz
RUN rm netboot.tar.gz

ADD pipework /usr/local/bin/
ADD setup-iptables /usr/local/bin/
CMD setup-iptables
