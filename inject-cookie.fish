#!/usr/bin/env fish

# Populate .Xauthority file from inside the docker container

set HOSTNAME $argv[1]

touch .Xauthority

set XSTRING (xauth -f .XauthorityFromHost list | rg $HOSTNAME -r (hostname) | string split '  ')

xauth -f .Xauthority add $XSTRING[1] $XSTRING[2] $XSTRING[3]

XAUTHORITY="/root/.Xauthority" emacs
