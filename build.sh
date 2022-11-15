#!/bin/bash

docker image rm pedrozc90/sbt:test

docker build --no-cache \
    --network host \
    --file ./Dockerfile \
    --tag pedrozc90/sbt:test \
    .

# exit if docker build fails
if [[ $? -ne 0 ]]; then
    exit $?
fi

docker run -it \
    --rm \
    --user runner \
    --name sbt \
    pedrozc90/sbt:test bash
