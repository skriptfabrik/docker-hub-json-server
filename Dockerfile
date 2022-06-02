FROM node:18.2.0-alpine

LABEL maintainer="Daniel Schröder <daniel.schroeder@skriptfabrik.com>"

ARG JSON_SERVER_VERSION=latest

ENV JSON_SERVER_HOST=0.0.0.0
ENV JSON_SERVER_PORT=80
ENV JSON_SERVER_ROUTES=/data/routes.json
ENV JSON_SERVER_SOURCE=/data/db.json

RUN set -eux; \
    npm install -g json-server@${JSON_SERVER_VERSION}; \
    rm -Rf ~/.npm; \
    mkdir -p /data; \
    echo '{}' > /data/db.json; \
    echo '{}' > /data/routes.json

WORKDIR /data

EXPOSE 3000

CMD [ "sh", "-c", "json-server --host $JSON_SERVER_HOST --port $JSON_SERVER_PORT --routes $JSON_SERVER_ROUTES --watch $JSON_SERVER_SOURCE" ]
