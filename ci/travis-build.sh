#!/bin/bash

echo "Starting to build docker image" 
docker build -t "arpit-test"
ls
docker run arpit-test
