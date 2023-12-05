
# https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/

ARG CADDY_VERSION
FROM --platform=$BUILDPLATFORM caddy:${CADDY_VERSION}-builder-alpine AS builder
ARG BUILDPLATFORM
ARG TARGETPLATFORM
ARG TARGETOS TARGETARCH

RUN echo "Building for $TARGETOS/$TARGETARCH on $BUILDPLATFORM"
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH xcaddy build ${CADDY_VERSION} \
  --with github.com/mholt/caddy-webdav
RUN echo "Built binary at: $(readlink -f caddy)"

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
