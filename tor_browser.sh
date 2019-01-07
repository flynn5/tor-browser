#!/bin/bash
#
# Runs Tor browser in a Docker container.
#
# Note.  This is customized for a MacOSX environment.
# Ensure XQartz and socat are installed, and socat is running with...
#  socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
#
docker run \
  --rm \ # leave no trace :D
  --name tor-browser \
  -e DISPLAY=docker.for.mac.host.internal:0 \ # works only on mac
  flynn5/tor-browser
