FROM ubuntu
MAINTAINER Laurens Stötzel <l.stoetzel@meeva.de>

# Install JpegTrag
RUN echo "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" > /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y libjpeg-progs

RUN mkdir -p /source
WORKDIR /source

ENTRYPOINT [ "/usr/bin/jpegtran" ]