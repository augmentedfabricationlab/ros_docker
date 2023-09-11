# https://github.com/solarkennedy/wine-x11-novnc-docker/tree/master
FROM ubuntu:focal
#focal ros:noetic
#bionic ros:melodic


RUN apt-get update && apt-get -y \
    install \
    python3 \
    python-is-python3 \
    xvfb \
    x11vnc \
    xdotool \
    wget \
    tar \
    supervisor \
    net-tools \
    fluxbox \
    gnupg2 \
    # apt-get update && apt-get -y install python2 python-is-python2 xvfb x11vnc xdotool wget tar supervisor net-tools fluxbox gnupg2 && \
    && apt-get -y full-upgrade \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_FLUXBOX=yes

WORKDIR /root/
RUN wget -O - https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-1.1.0 /root/novnc && ln -s /root/novnc/vnc_lite.html /root/novnc/index.html && \
    wget -O - https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /root/ && mv /root/websockify-0.9.0 /root/novnc/utils/websockify

EXPOSE 8080

CMD ["/usr/bin/supervisord"]