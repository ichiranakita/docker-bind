FROM sameersbn/ubuntu:14.04.20150613
MAINTAINER sameer@damagehead.com

ENV BIND_USER=bind \
    WEBMIN_VERSION=1.740

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
 && apt-get update \
 && apt-get install -y bind9 perl libnet-ssleay-perl openssl \
      libauthen-pam-perl libpam-runtime libio-pty-perl \
      apt-show-versions python pwgen \
 && wget "http://prdownloads.sourceforge.net/webadmin/webmin_${WEBMIN_VERSION}_all.deb" -P /tmp/ \
 && dpkg -i /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /tmp/webmin_${WEBMIN_VERSION}_all.deb \
 && rm -rf /var/lib/apt/lists/*

COPY start /start
RUN chmod 755 /start

EXPOSE 53/udp 10000/tcp
VOLUME ["/data"]
CMD ["/start"]
