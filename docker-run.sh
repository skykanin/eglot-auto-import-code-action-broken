#!/usr/bin/env sh

set -x

WORKDIR="/root"

docker run -it --rm \
    -w "$WORKDIR" \
    -e DISPLAY="$DISPLAY" \
    -e XAUTHORITY="$XAUTHORITY" \
    --name repr-devel \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$HOME/.Xauthority:$WORKDIR/.XauthorityFromHost" \
    repro-image:v1 "$(hostname)"
