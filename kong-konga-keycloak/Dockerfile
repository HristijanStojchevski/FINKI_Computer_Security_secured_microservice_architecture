FROM kong:2.0.0-alpine

LABEL description="Alpine + Kong 2.0.0 + kong-oidc plugin"

USER root

RUN apk update 

RUN apk add build-base bash curl unzip git

RUN apk add lua5.1 lua5.1-dev
RUN apk add openssl openssl-dev

# Build Luarocks.
RUN cd /tmp && \
    git clone https://github.com/keplerproject/luarocks.git && \
    cd luarocks && \
    sh ./configure && \
    make build install && \
    cd && \
    rm -rf /tmp/luarocks

RUN luarocks install kong-enhanced-oidc
RUN luarocks install kong-plugin-cookies-to-headers

COPY nginx-redis.kong.conf /usr/local/kong

USER kong