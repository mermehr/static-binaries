#!/bin/bash

# Output directory
mkdir -p binaries

build_in_docker() {
    local ARCH=$1
    local IMAGE=$2

    echo "--- Building ptunnel-ng for $ARCH using $IMAGE ---"

    docker build --build-arg BASE_IMAGE=$IMAGE -t builder-$ARCH .

    docker run --rm -v "$(pwd)/binaries:/output" builder-$ARCH sh -c '
        echo "Building ptunnel-ng..."
        git clone https://github.com/utoni/ptunnel-ng.git
        cd ptunnel-ng
        ./autogen.sh

        sed -i "1i #include <netinet/in.h>" src/ptunnel.h

        ./configure LDFLAGS="-static" CFLAGS="-static"
        make
        strip src/ptunnel-ng
        cp src/ptunnel-ng /output/ptunnel-ng-'$ARCH'
        cd ..
    '
}

# Run for x64
build_in_docker "x64" "alpine:edge"

# Run for x86
build_in_docker "x86" "i386/alpine:edge"

echo "Build complete. Check ./binaries folder."
