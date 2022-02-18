#!/bin/bash

docker build --no-cache \
    --network host \
    --file ./Dockerfile \
    --tag sbt:latest \
    .

docker run -it --rm --name sbt sbt:latest bash
