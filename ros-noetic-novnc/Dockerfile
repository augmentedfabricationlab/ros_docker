# https://github.com/solarkennedy/wine-x11-novnc-docker/tree/master
FROM ubuntu:focal
#focal(20) ros:noetic
#bionic(18) ros:melodic
#xenial(16) ros:kinetic
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    bash \
    ca-certificates \
    git \
    git-core \
    procps \
    python3 \
    python-is-python3 \
    xvfb \
    x11vnc \
    xterm \
    xdotool \
    wget \
    tar \
    socat \
    supervisor \
    net-tools \
    fluxbox \
    gnupg2 \
    # apt-get update && apt-get -y install python2 python-is-python2 xvfb x11vnc xdotool wget tar supervisor net-tools fluxbox gnupg2 && \
    && apt-get -y full-upgrade \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD ./.supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    TZ=Europe/Berlin \
    # DISPLAY_WIDTH=1600 \
    # DISPLAY_HEIGHT=1200 \
    RUN_FLUXBOX=yes
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /root/ \
    && mv /root/noVNC-1.1.0 /root/novnc \
    && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html \ 
    && wget -O - https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /root/ \
    && mv /root/websockify-0.9.0 /root/novnc/utils/websockify

 COPY . /root

EXPOSE 8080

# CMD ["/usr/bin/supervisord"]
CMD ["supervisord", "-c", "/root/.supervisord/supervisord.conf"]