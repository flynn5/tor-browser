FROM debian

ENV DEBIAN_FRONTEND=noninteractive HOME=/home/anon

ENV TOR_VERSION=8.5a3
# Via https://dist.torproject.org/torbrowser/$TOR_VERSION/sha256sums-signed-build.txt
ENV SHA256_CHECKSUM=5079b8cf7ca0e0430c324dcb25257e39e8a8a98fc2aa6c22aadaf2981ac1adc2
ENV LANG=C.UTF-8
ENV RELEASE_FILE=tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz
ENV RELEASE_URL=https://dist.torproject.org/torbrowser/${TOR_VERSION}/${RELEASE_FILE}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      file \
      gpg \
      libx11-xcb1 \
      libasound2 \
      libdbus-glib-1-2 \
      libgtk-3-0 \
      libxrender1 \
      libxt6 \
      xz-utils && \
    localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

RUN useradd -m -d /home/anon anon

WORKDIR /home/anon

RUN gpg --keyserver ha.pool.sks-keyservers.net \
      --recv-keys "EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290" && \
    curl -sSL -o /home/anon/tor.tar.xz \
      ${RELEASE_FILE} && \
    curl -sSL -o /home/anon/tor.tar.xz.asc \
      ${RELEASE_FILE}.asc && \
    gpg --verify /home/anon/tor.tar.xz.asc && \
    tar xvf /home/anon/tor.tar.xz && \
    rm -f /home/anon/tor.tar.xz*

RUN mkdir /home/anon/Downloads && \
    chown -R anon:anon /home/anon && \
    apt-get autoremove

USER anon

CMD /home/anon/tor-browser_en-US/Browser/start-tor-browser
