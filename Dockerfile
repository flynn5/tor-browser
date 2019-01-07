FROM debian

ENV LANG=C.UTF-8

ENV DEBIAN_FRONTEND=noninteractive 

ENV ANON_USER=anon
ENV HOME=/home/${ANON_USER}
ENV TOR_DL=tor.tar.xz

ENV TOR_VERSION=8.0.4
# The following filenames and URLs may change with TOR_VERSION.  Check!
ENV RELEASE_FILE=tor-browser-linux64-${TOR_VERSION}_en-US.tar.xz
ENV RELEASE_URL=https://dist.torproject.org/torbrowser/${TOR_VERSION}/${RELEASE_FILE}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      file \
      gpg \
      dirmngr \
      libx11-xcb1 \
      libasound2 \
      libdbus-glib-1-2 \
      libgtk-3-0 \
      libxrender1 \
      libxt6 \
      xz-utils 

RUN useradd -m -d ${HOME} ${ANON_USER}

WORKDIR ${HOME}

RUN gpg --batch --keyserver hkp://pgp.mit.edu:80 \
      --recv-keys "EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290" && \
    curl -sSL -o ${HOME}/${TOR_DL} \
      ${RELEASE_URL} && \
    curl -sSL -o ${HOME}/${TOR_DL}.asc \
      ${RELEASE_URL}.asc && \
    gpg --batch --verify ${HOME}/${TOR_DL}.asc ${HOME}/${TOR_DL} && \
    tar xvf ${HOME}/${TOR_DL} && \
    rm -f ${HOME}/${TOR_DL}*

RUN mkdir ${HOME}/Downloads && \
    chown -R ${ANON_USER}:${ANON_USER} ${HOME} && \
    apt-get autoremove

USER ${ANON_USER}

CMD ${HOME}/tor-browser_en-US/Browser/start-tor-browser

