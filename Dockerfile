FROM alpine:3.17

RUN apk add --no-cache \
    bash \
    wget \
    lynx \
    bind-tools \
    iptables \
    ip6tables \
    openvpn

COPY . /usr/local/bin

WORKDIR /usr/local/bin

COPY config /usr/local/bin

RUN ["chmod", "+x", "/usr/local/bin/entry.sh"]

ENV KILL_SWITCH=on

ENTRYPOINT [ "/usr/local/bin/entry.sh" ]
