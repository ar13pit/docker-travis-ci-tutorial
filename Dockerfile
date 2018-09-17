# ----------------------------------------------------------
#       Dockerfile to build base working Ubuntu image
# ----------------------------------------------------------

# Set the base image to Ubuntu 16.04
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Arpit Aggarwal

# Make image to be noninteractive to use with CI
# Comment this line when not using this image with CI
ENV DEBIAN_FRONTEND=noninteractive

# Update the image
RUN apt-get update

# Install basic packages
RUN apt-get install --assume-yes --no-install-recommends sudo apt-utils git wget curl 
#lsb-release

# Add user Avular with SUDO previleges and disable SUDO password
RUN adduser --disabled-password --gecos "" arpit
RUN addgroup arpit adm
RUN addgroup arpit sudo
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/arpit

# Set WORKDIR to home of Avular
WORKDIR /home/arpit

# Copy contents of repository into directory _git in the home of the user
COPY / ./_git/

# Start container of the Docker image at bash prompt
CMD ["/bin/bash"]

