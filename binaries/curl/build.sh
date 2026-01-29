#!/bin/bash

# Output directory
mkdir -p binaries

build_in_docker() {
    local ARCH=$1
    local IMAGE=$2

    echo "--- Building curl for $ARCH using $IMAGE ---"

    docker build --build-arg BASE_IMAGE=$IMAGE -t builder-$ARCH .

    docker run --rm -v "$(pwd)/binaries:/output" builder-$ARCH sh -c '
        echo "Building curl..."
        git clone -b curl-8_6_0 https://github.com/curl/curl.git
        cd curl
        autoreconf -fi

        ./configure \
            --disable-shared \
            --enable-static \
            --with-openssl \
            --with-zlib \
            --with-nghttp2 \
            --disable-dict \
            --disable-gopher \
            --disable-ldap \
            --disable-ldaps \
            --disable-rtsp \
            --disable-pop3 \
            --disable-imap \
            --disable-smtp \
            --disable-telnet \
            --disable-tftp \
            --without-libpsl \
            --without-libidn2 \
            --without-brotli \
            LDFLAGS="-static" \
            PKG_CONFIG="pkg-config --static"

        make curl_LDFLAGS="-all-static"
        strip src/curl
        cp src/curl /output/curl-'$ARCH'
    '
}

# Run for x64
build_in_docker "x64" "alpine:edge"

# Run for x86
build_in_docker "x86" "i386/alpine:edge"

echo "Build complete. Check ./binaries folder."
