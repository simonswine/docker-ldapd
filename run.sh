#!/bin/bash

SRV_PATH=/srv
DATA_PATH=${SRV_PATH}/data
CONFIG_PATH=${SRV_PATH}/config
ORIG_CONFIG_PATH=/etc/ldap/slapd.d/

USER=openldap
GROUP=openldap

if [ ! -d ${SRV_PATH} ]; then
    mkdir ${SRV_PATH}
fi

if [ ! -d ${DATA_PATH} ]; then
    mkdir ${DATA_PATH}
    chown ${USER}:${GROUP} ${DATA_PATH}
    chmod 750 ${DATA_PATH}
fi

if [ ! -d ${CONFIG_PATH} ]; then
    cp -a ${ORIG_CONFIG_PATH} ${CONFIG_PATH}
    chown -R ${USER}:${GROUP} ${CONFIG_PATH}
    chmod -R o-rwx ${CONFIG_PATH}
    sed -i 's/\/var\/lib\/ldap/\/srv\/data/g' ${CONFIG_PATH}/cn\=config/olcDatabase\=\{1\}hdb.ldif
fi

# Starting supervisord
supervisord -n -c /etc/supervisor/supervisord.conf
