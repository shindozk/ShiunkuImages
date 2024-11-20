FROM --platform=$TARGETOS/$TARGETARCH node:20-bullseye-slim

RUN apt update \
    && apt -y install ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool \
    && useradd -m -d /home/container container

RUN npm install npm@latest -g

WORKDIR /app/data

CMD ["eval", $START]
