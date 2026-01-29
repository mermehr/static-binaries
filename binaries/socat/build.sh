#!/bin/bash

# Output directory
mkdir -p binaries

build_in_docker() {
    local ARCH=$1
    local IMAGE=$2

    echo "--- Building socat for $ARCH using $IMAGE ---"

    docker build -f Dockerfile --build-arg BASE_IMAGE=$IMAGE -t builder-socat-$ARCH .

    docker run --rm -v "$(pwd)/binaries:/output" builder-socat-$ARCH sh -c '
        echo "Cloning socat..."
        git clone git://repo.or.cz/socat.git
        cd socat
        git checkout v1.8.0.0

        echo "Configuring socat..."
        autoconf

        echo "#ifndef NETDB_INTERNAL" >> compat.h
        echo "#define NETDB_INTERNAL (-1)" >> compat.h
        echo "#endif" >> compat.h

        sed -i "1i #include <netinet/in.h>" sysincludes.h

        ./configure \
            --enable-openssl \
            --disable-readline \
            --disable-libwrap \
            --disable-shared \
            LDFLAGS="-static" \
            CFLAGS="-static"

        echo "Compiling..."
        make

        echo "Stripping..."
        strip socat
        cp socat /output/socat-linux-'$ARCH'
    '
}

# Run for x64
build_in_docker "x64" "alpine:3.20"

# Run for x86
build_in_docker "x86" "i386/alpine:3.20"

echo "Build complete. Check ./binaries folder."
