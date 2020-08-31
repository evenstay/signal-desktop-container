FROM debian:latest
LABEL version "0.1"

ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY :0
ENV XDG_CONFIG_HOME '$HOME/.config'
ENV DBUS_SESSION_BUS_ADDRESS '$DBUS_SESSION_BUS_ADDRESS'

VOLUME ["/tmp/.X11-unix"]

RUN groupadd signal
RUN useradd -d '/opt/signal' \
    -s '/usr/sbin/nologin' \
    -u '1000' \
    -g signal signal

ADD https://updates.signal.org/desktop/apt/keys.asc /opt/signal/signal-key.asc
ADD signal-xenial.list /opt/signal/signal-xenial.list

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    apt-transport-https \
    gnupg \
    libasound2
    
RUN apt-key add /opt/signal/signal-key.asc

RUN cp /opt/signal/signal-xenial.list /etc/apt/sources.list.d/signal-xenial.list
RUN apt-get update
RUN apt-get install -y signal-desktop

RUN chown -Rf signal.signal /opt/signal

USER signal

CMD signal-desktop
