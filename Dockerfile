FROM debian:sid-slim

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=en_US:en

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN set -x && \
    TEMP_PACKAGES=() && \
    KEPT_PACKAGES=() && \
    # Packages only required during build
    TEMP_PACKAGES+=(git) && \
    TEMP_PACKAGES+=(make) && \
    TEMP_PACKAGES+=(pandoc) && \
    # Packages kept in the image
    KEPT_PACKAGES+=(bash) && \
    TEMP_PACKAGES+=(build-essential) && \
    KEPT_PACKAGES+=(ca-certificates) && \
    KEPT_PACKAGES+=(ffmpeg) && \
    KEPT_PACKAGES+=(locales) && \
    KEPT_PACKAGES+=(locales-all) && \
    KEPT_PACKAGES+=(mpv) && \
    KEPT_PACKAGES+=(python3) && \
    TEMP_PACKAGES+=(python3-dev) && \
    KEPT_PACKAGES+=(python-is-python3) && \
    KEPT_PACKAGES+=(python3-pip) && \
    KEPT_PACKAGES+=(rtmpdump) && \
    KEPT_PACKAGES+=(zip) && \
    KEPT_PACKAGES+=(atomicparsley) && \
    KEPT_PACKAGES+=(aria2) && \
    KEPT_PACKAGES+=(adduser) && \
    # Install packages
    apt update -y && \
    apt install -y --no-install-recommends \
    ${KEPT_PACKAGES[@]} \
    ${TEMP_PACKAGES[@]} \
    && \
    git config --global advice.detachedHead false && \
    # Install required python modules
    pip install --no-cache-dir --break-system pyxattr && \
    # Install yt-dlp via pip
    pip install --no-cache-dir --break-system --force-reinstall yt-dlp && \
    # Create /config directory
    mkdir -p /config && \
    # Clean-up
    apt remove -y ${TEMP_PACKAGES[@]} && \
    apt autoremove -y && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /src && \
    # Document version
    yt-dlp --version > /IMAGE_VERSION

# # Copy init script, set workdir & entrypoint
COPY init /init
WORKDIR /workdir
ENTRYPOINT ["/init"]
