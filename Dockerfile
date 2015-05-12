#
# Base Image
#

FROM debian:jessie
MAINTAINER Stéphane Cottin <stephane.cottin@vixns.com>
ENV DEBIAN_FRONTEND noninteractive

# Add filters for documentation
ADD dpkg_nodoc /etc/dpkg/dpkg.cfg.d/01_nodoc
ADD dpkg_nolocales /etc/dpkg/dpkg.cfg.d/01_nolocales
ADD apt_nocache /etc/apt/apt.conf.d/02_nocache
ADD remove_doc.sh /usr/local/bin/remove_doc
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -y lsb-release apt-utils && \
  echo "deb http://http.debian.net/debian `lsb_release -cs`-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list && \
  apt-get update -q && \
  apt-get install -t `lsb_release -cs`-backports -y --no-install-recommends unzip vim jq curl dnsutils && \
  curl -s http://apt.vixns.net/vixns.gpg | apt-key add - && \
  echo "deb http://apt.vixns.net `lsb_release -cs` main contrib non-free" > /etc/apt/sources.list.d/vixns.list && \
  apt-get update -q && \
  apt-get -y dist-upgrade --no-install-recommends && \
  apt-get -y autoremove && \
  apt-get -y autoclean && \
  apt-get -y clean && \
  rm -rf /var/lib/apt/lists/*

RUN /usr/local/bin/remove_doc

COPY ./dig-srv.sh /usr/bin/dig-srv
RUN chmod +x /usr/bin/dig-srv