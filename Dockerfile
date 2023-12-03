ARG CADDY_VERSION=2.7.0
FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build ${CADDY_VERSION} \
  --with github.com/mholt/caddy-webdav

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
