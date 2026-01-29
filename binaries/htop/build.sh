#!/bin/bash

# Output directory
mkdir -p binaries

build_in_docker() {
    local ARCH=$1
    local IMAGE=$2

    echo "--- Building htop for $ARCH using $IMAGE ---"

    docker build --build-arg BASE_IMAGE=$IMAGE -t builder-$ARCH .

    docker run --rm -v "$(pwd)/binaries:/output" builder-$ARCH sh -c '
        echo "Building htop..."
        git clone https://github.com/htop-dev/htop.git
        cd htop
        ./autogen.sh
        ./configure \
            --enable-static \
            --disable-shared \
            --disable-unicode \
            --disable-sensors \
            LDFLAGS="-static"

        make
        strip htop
        cp htop /output/htop-'$ARCH'
    '
}

# Run for x64
build_in_docker "x64" "alpine:edge"

# Run for x86
build_in_docker "x86" "i386/alpine:edge"

echo "Build complete. Check ./binaries folder."
