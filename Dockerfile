FROM alpine:3.15 AS build

ENV SBT_VERSION=0.13.18
ENV SBT_HOME="/usr/local/sbt"

# create a dedicated group and user
RUN addgroup -g 1000 runner \
    && adduser -u 1000 -G runner -s /bin/sh -D runner

# install tools and dependecies
RUN apk update \
    && apk add --no-cache --upgrade --virtual .build-tools bash \
    && apk add --no-cache --upgrade --virtual .build-deps \
    ca-certificates \
    curl \
    wget \
    tar

# install java
RUN curl -fsSLO --compressed "http://dl-cdn.alpinelinux.org/alpine/v3.15/community/x86_64/openjdk8-8.302.08-r2.apk" \
    && apk add "openjdk8-8.302.08-r2.apk" \
    && rm -v "openjdk8-8.302.08-r2.apk"

# install sbt
RUN mkdir -vp "${SBT_HOME}" \
    && wget --inet4-only "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" \
    && tar -zxvf "sbt-${SBT_VERSION}.tgz" -C "${SBT_HOME}" --strip-components=1 \
    && rm -rf "sbt-${SBT_VERSION}.tgz" \
    && ln -sf "${SBT_HOME}/bin/sbt" "/usr/bin/sbt" \
    && sbt sbtVersion

# cleaning image
RUN apk del .build-deps \
    && rm -rfv /tmp/*
