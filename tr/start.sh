#!/bin/sh
chown -R ${UID}:${GID} /transmission
su-exec ${UID}:${GID} /transmission/transmission-daemon -g ${TRANSMISSION_CONFIG} -f -B -t -u ${TR_USER} -v ${TR_PASSWORD} -a *.*.*.*