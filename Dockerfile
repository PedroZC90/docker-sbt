FROM alpine:3.15 AS build

ENV SBT_VERSION=0.13.18
ENV SBT_HOME="/usr/local/sbt"

RUN apk update \
    && apk add --no-cache --upgrade bash \
    && apk add --no-cache --upgrade --virtual .build-deps \
    ca-certificates \
    curl \
    git \
    tar \
    wget

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

RUN apk del .buidl-deps \
    && rm -rfv "/tmp/"*
