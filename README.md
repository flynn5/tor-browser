# tor-browser

This repo defines the `flynn5/tor-browser` Docker image which is the tor-browser packaged up within a container.

For MacOSX:

To launch the tor-browser on MacOSX, first ensure XQartz and socat are installed, and socat is running with...
``` socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\ &" ```
then

```
docker run --rm --name tor-browser \
           -e DISPLAY=docker.for.mac.host.internal:0 \
           flynn5/tor-browser

```
If you want to specify a custom `torrc` file, that can be done with:
```
docker run --rm --name tor-browser \
           -v /host/dir/containing/torrc:/conf:ro \
           -e TORRC_PATH=/conf/torrc \
           -e DISPLAY=docker.for.mac.host.internal:0 \
           flynn5/tor-browser
```

For unix:
```
docker run --rm --name tor-browser \
           -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
           -e DISPLAY=unix$DISPLAY \
           flynn5/tor-browser
```
and with custom torrc file:
```
docker run --rm --name tor-browser \
           -v /host/dir/containing/torrc:/conf:ro \
           -e TORRC_PATH=/conf/torrc \
           -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
           -e DISPLAY=unix$DISPLAY \
           flynn5/tor-browser
```
