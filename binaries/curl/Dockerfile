# Build argument to swap between alpine:edge and i386/alpine:edge
ARG BASE_IMAGE=alpine:edge
FROM ${BASE_IMAGE}

# Install build dependencies and static libraries
RUN apk add --no-cache \
    bash \
    build-base \
    git \
    automake \
    autoconf \
    libtool \
    linux-headers \
    pkgconf \
    openssl-dev \
    openssl-libs-static \
    zlib-dev \
    zlib-static \
    nghttp2-dev \
    nghttp2-static \
    ncurses-dev \
    ncurses-static

WORKDIR /build
