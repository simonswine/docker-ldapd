FROM ubuntu:trusty
MAINTAINER Christian Simon <simon@swine.de>

# Upgrade/Install Packages
RUN apt-get update &&  \
    DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install slapd ldap-utils supervisor && \
    apt-get clean && \
    rm /var/lib/apt/lists/*_*

# Volume in /srv
VOLUME /srv

# Add run script
ADD ./supervisord.slapd.conf /etc/supervisor/conf.d/slapd.conf

# Add run.sh
ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD /run.sh

EXPOSE 389
EXPOSE 636
