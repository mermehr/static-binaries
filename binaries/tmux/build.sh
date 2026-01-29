#!/bin/bash

# Output directory
mkdir -p binaries

build_in_docker() {
    local ARCH=$1
    local IMAGE=$2

    echo "--- Building tmux for $ARCH using $IMAGE ---"

    docker build -f Dockerfile.tmux --build-arg BASE_IMAGE=$IMAGE -t builder-tmux-$ARCH .

    docker run --rm -v "$(pwd)/binaries:/output" builder-tmux-$ARCH sh -c '
        echo "Cloning tmux..."
        git clone https://github.com/tmux/tmux.git
        cd tmux
        git checkout 3.5a

        echo "Configuring..."
        ./autogen.sh

        ./configure \
            --enable-static \
            LDFLAGS="-static" \
            PKG_CONFIG="pkg-config --static"

        echo "Compiling..."
        make

        echo "Stripping..."
        strip tmux
        cp tmux /output/tmux-linux-'$ARCH'
    '
}

# Run for x64
build_in_docker "x64" "alpine:3.20"

# Run for x86
build_in_docker "x86" "i386/alpine:3.20"

echo "Build complete. Check ./binaries folder."
