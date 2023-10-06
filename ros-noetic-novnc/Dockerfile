# https://github.com/solarkennedy/wine-x11-novnc-docker/tree/master
FROM ubuntu:focal
#focal(20) ros:noetic
#bionic(18) ros:melodic
#xenial(16) ros:kinetic
ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb \
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

COPY . /root

EXPOSE 8080

# CMD ["/usr/bin/supervisord"]
CMD ["supervisord", "-c", "/root/.supervisord/supervisord.conf"]