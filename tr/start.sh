#!/bin/sh
chown -R ${UID}:${GID} /transmission
su-exec ${UID}:${GID} /usr/local/bin/transmission-daemon -g ${TRANSMISSION_CONFIG} -f -B -t -u ${TR_USER} -v ${TR_PASSWORD} -a *.*.*.*