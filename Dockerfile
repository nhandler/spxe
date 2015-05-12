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

RUN rm /etc/dnsmasq.conf
ADD dnsmasq.conf /etc/

#ADD pipework /usr/local/bin/
#ADD setup-iptables /usr/local/bin/

ENTRYPOINT /usr/sbin/dnsmasq
#CMD ["--interface=eth1","--dhcp-range=192.168.242.2,192.168.242.99,255.255.255.0,1h","--dhcp--boot=pxelinux.0,pxeserver,192.168.242.1","--pxe-service=x86PC,\"Install Linux\",pxelinux","--enable-tftp","--tftp-root=/srv/tftp/","--no-daemon"]
