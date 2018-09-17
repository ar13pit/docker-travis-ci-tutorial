#!/bin/bash

echo -e "\e[35m\e[1mCreating docker image \e[0m"

docker build -t "arpit-test" .

echo -e "\e[35m\e[1mSteps after build \e[0m"
ls
docker run arpit-test
