#!/bin/bash

echo -e "\e[35m\e[1mCreating docker image \e[0m"

docker build -t arpit-test .
docker run -d --name arpit-env -t arpit-test:latest

