#!/bin/bash

docker build --no-cache \
    --network host \
    --file ./Dockerfile \
    --tag pedrozc90/sbt:latest \
    .

docker run -it --rm --name sbt pedrozc90/sbt:latest bash
