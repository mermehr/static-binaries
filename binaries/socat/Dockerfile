ARG BASE_IMAGE=alpine:edge
FROM ${BASE_IMAGE}

RUN apk add --no-cache \
    bash \
    build-base \
    git \
    automake \
    autoconf \
    libtool \
    linux-headers \
    pkgconf \
    bison \
    openssl-dev \
    openssl-libs-static

WORKDIR /build
