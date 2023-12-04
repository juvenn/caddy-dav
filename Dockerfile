ARG CADDY_VERSION
FROM --platform=$BUILDPLATFORM caddy:${CADDY_VERSION}-builder-alpine AS builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN xcaddy build ${CADDY_VERSION} \
  --with github.com/mholt/caddy-webdav

FROM --platform=$BUILDPLATFORM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
