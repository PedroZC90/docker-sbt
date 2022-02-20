#!/bin/bash

docker build --no-cache \
    --network host \
    --file ./Dockerfile \
    --tag pedrozc90/sbt:test \
    .

docker run -it \
    --rm \
    --user runner \
    --name sbt \
    pedrozc90/sbt:test bash
