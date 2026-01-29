ARG BASE_IMAGE=alpine:3.20
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
    ncurses-dev \
    ncurses-static \
    libevent-dev \
    libevent-static

WORKDIR /build