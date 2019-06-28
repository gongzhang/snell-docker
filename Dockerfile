FROM ubuntu:16.04 AS helper
RUN apt-get update && \
    apt-get install -y wget unzip

WORKDIR /root

RUN wget https://github.com/surge-networks/snell/releases/download/v1.1.1/snell-server-v1.1.1-linux-amd64.zip -O snell.zip && \
    unzip snell.zip && \
    rm snell.zip


FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -y gettext-base && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root
COPY --from=helper /root/snell-server /usr/local/bin/snell-server
COPY . .

ENV PSK=ABCDEFGHIJKLMNOPQRSTUVWXYZ12345 \
    OBFS=http

EXPOSE 8000

CMD envsubst < snell-server.conf.template > snell-server.conf && snell-server
