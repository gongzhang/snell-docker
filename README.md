# snell-docker

An docker image for [surge-networks/snell](https://github.com/surge-networks/snell).

## Quickstart

Start up a simple HTTP obfuscating proxy using `docker-compose`:

```yaml
# docker-compose.yml

version: "3"
services:
  snell:
    image: gongzhang/snell
    environment:
      # replace with your own PSK!
      - PSK=ABCDEFGHIJKLMNOPQRSTUVWXYZ12345
    ports:
      # expose on port 54321
      - 54321:8000
```

To generate a random PSK, try this:

```
docker run --rm -it gongzhang/snell /bin/sh -c "echo | snell-server | grep PSK"
```

## Custom Configuration

To use custom configuration, you need to override `CMD` defined in the image:

```yaml
# docker-compose.yml

version: "3"
services:
  snell:
    image: gongzhang/snell
    command: snell-server
    volumes:
      - my-snell-server.conf:/root/snell-server.conf
    environment:
      - PSK=ABCDEFGHIJKLMNOPQRSTUVWXYZ12345
    ports:
      - 54321:8000
```
