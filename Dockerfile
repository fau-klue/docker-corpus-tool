FROM ubuntu:zesty

# Install cwb dependencies
RUN apt-get update && \
    apt-get install -y apt-utils autoconf bison flex gcc make pkg-config libc6-dev libncurses5 libncurses5-dev libpcre3-dev libglib2.0-0 libglib2.0-dev libreadline6 libreadline6-dev && \
    apt-get install -y subversion && \
    rm -rf /var/lib/apt/lists/*

# Download latest cwb source
RUN svn co http://svn.code.sf.net/p/cwb/code/cwb/trunk cwb
WORKDIR /cwb

RUN ./install-scripts/cwb-install-ubuntu

# TODO: hardcoded version is not optimal
ENV PATH="/usr/local/cwb-3.4.12/bin/:${PATH}"

VOLUME /var/cwb