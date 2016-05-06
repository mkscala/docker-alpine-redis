# Redis 3.2.0

FROM gliderlabs/alpine:3.3
MAINTAINER Adrian B. Danieli "https://github.com/sickp"

RUN \
  build_packages="build-base linux-headers openssl" && \
  apk --update add ${build_packages} && \
  wget -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.8/gosu-amd64 && \
  chmod +x /usr/local/bin/gosu && \
  cd /tmp && \
  wget http://download.redis.io/releases/redis-3.2.0.tar.gz && \
  tar xzf redis-3.2.0.tar.gz && \
  cd /tmp/redis-3.2.0 && \
  make && \
  make install && \
  cp redis.conf /etc/redis.conf && \
  adduser -D redis && \
  mkdir /data && \
  chown redis:redis /data && \
  rm -rf /tmp/* && \
  apk del ${build_packages} && \
  rm -rf /var/cache/apk/*

VOLUME ["/data"]
WORKDIR /data

EXPOSE 6379

COPY rootfs /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis-server", "/etc/redis.conf"]
