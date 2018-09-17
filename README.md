# Minimalistic tutorial for using Docker with Travis-CI ![travis](https://travis-ci.org/ar13pit/docker-travisci-test.svg?branch=master)


This repository serves as a tutorial and reference for starting to use a CI service like Travis-CI and containerization enironment Docker.

Travis-CI has an Ubuntu 14.04 VM running, hence software builds and tests heavily dependent on Ubuntu versions later than 14.04 need to abstracted into a separate container made using Docker.

## Docker
To setup a Docker container first a Docker image needs to be built using a [Dockerfile](https://docs.docker.com/engine/reference/builder/). A sample of such Dockerfile can be seen in this repository. The comments are self-explanatory and futher documentation can be referred to on the site of Docker.

Once this Dockerfile is prepared, the Docker image can be created with a single command:
```
docker build -t <Name_of_image> <Location_of_Dockerfile>

example:
docker build -t arpit-test .
```

Upon successful build of an image, a container can be started with:
```
docker run -d --name <Name_of_container> -t <Name_of_created_image>

example:
docker run -d --name arpit-env -t arpit-test
```

An application can be run on a running container with:
```
docker exec <Name_of_running_container> <Path_to_application_executable>

example:
docker exec arpit-env ./_git/install_packages.bash
```

To setup Docker on a local machine, one must follow the installation process described in the [Installation Guide](https://docs.docker.com/install/). Other processes of using a Dockerfile, building an image, etc. remain the same as described above. To execute commands on a local machine, ```sudo``` privileges may be required.

## Travis-CI
Travis-CI for a repository can be setup by logging onto [Travis-CI](https://travis-ci.org/) and activating the repository. Once this is done, a ```.travis.yml``` file must be added to the root of the repository. There is a heavy tutorial on the website of Travis-CI on how to setup this file, although most part of it of no use when using Docker for containerization. This repository uses a minimalistic ```.travis.yml``` setup. The first three statements in the file:
```
sudo: required
language: bash

services:
    - docker
    
script:
    - ci/travis-build.bash
    - ci/travis-install_packages.bash
    - ci/travis-unittests.bash
```
are mandatory to setup a Docker environment. (```language``` field is not necessary, but when not specified Travis tends to select the default as ```Ruby``` and starts installing its package management environment ```gems```).

The last field in the file: ```script``` tells Travis-CI which scripts from the repository must be executed and in which order. Here the Docker image can be built and a container can be started in which unit tests (or anyother processes) need to run.

A build is declared successful if the ```exit code``` for all the scripts/processes is ```0```.
