FROM ubuntu
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TZ=Asia/Shanghai apt-get install -y --no-install-recommends curl tzdata git \
    libcurl4-openssl-dev gcc libc-dev cmake make gettext libssl-dev git g++ build-essential automake python3 \
    && curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c -k \
    && gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec \
    && chown root:root /usr/local/bin/su-exec \
    && chmod 0755 /usr/local/bin/su-exec \
    && export GIT_SSL_NO_VERIFY=1 && git clone https://github.com/Shurelol/transmission.git /tmp/transmission \
    && cd /tmp/transmission && mkdir build && cd build \
    && git submodule update --init --recursive \
    && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. \
    && make && make install \
    && apt-get purge -y --auto-remove git libcurl4-openssl-dev gcc libc-dev cmake make \
    gettext libssl-dev git g++ build-essential automake python3 \
    && rm -rf /tmp/* /root/.cache /var/lib/apt/lists/* /usr/local/bin/transmission-create \
    /usr/local/bin/transmission-edit /usr/local/bin/transmission-remote  /usr/local/bin/transmission-show
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
