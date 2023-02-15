FROM ubuntu
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl unzip tzdata gcc libc-dev \
    && curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c -k \
    && gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec \
    && chown root:root /usr/local/bin/su-exec \
    && chmod 0755 /usr/local/bin/su-exec \
    && curl -o  \
    /tmp/transmission-daemon.zip -L \
    https://github.abskoop.workers.dev/https://github.com/HHANCLUB/docker-transmission/releases/download/1.0/transmission-daemon.zip -k \
    && unzip -d /transmission /tmp/transmission-daemon.zip \
    && rm -rf /tmp/* /root/.cache /var/lib/apt/lists/* /usr/local/bin/su-exec.c \
    && apt-get purge -y --auto-remove unzip gcc libc-dev
ENV LANG="C.UTF-8" \
    TZ="Asia/Shanghai" \
    TRANSMISSION_WEB_HOME="/transmission/web_ui" \
    TRANSMISSION_CONFIG="/transmission/config" \
    TR_USER="admin" \
    TR_PASSWORD="password" \
    TR_WEB_PORT=9091 \
    TR_PEER_PORT=51413 \
    UID=0 \
    GID=0 \
    UMASK=000 \
    WORKDIR="/transmission"
WORKDIR ${WORKDIR}
COPY tr/ ./
RUN ["chmod", "+x", "/transmission/start.sh"]

EXPOSE 9091 51413/tcp 51413/udp
ENTRYPOINT ["/transmission/start.sh"]
