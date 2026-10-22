
# https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/

ARG CADDY_VERSION=2.9.1
FROM --platform=$BUILDPLATFORM caddy:${CADDY_VERSION}-builder-alpine AS builder

ARG CADDY_VERSION
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

RUN echo "Building for $TARGETOS/$TARGETARCH on $BUILDPLATFORM"
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH GOARM=${TARGETVARIANT#v} xcaddy build ${CADDY_VERSION} \
  --with github.com/mholt/caddy-webdav
RUN echo "Built binary at: $(readlink -f caddy)"

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
