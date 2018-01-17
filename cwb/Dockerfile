FROM ubuntu:xenial as builder

# Install cwb dependencies
RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    autoconf \
    bison \
    flex \
    gcc \
    libc6-dev \
    libglib2.0-0 \
    libglib2.0-dev \
    libncurses5 \
    libncurses5-dev \
    libpcre3-dev \
    libreadline6 \
    libreadline6-dev \
    make \
    pkg-config \
    subversion \
    && rm -rf /var/lib/apt/lists/*

# Download latest cwb source
RUN svn co http://svn.code.sf.net/p/cwb/code/cwb/trunk /cwb

# Run install script and Move to unified location
WORKDIR /cwb
RUN ./install-scripts/cwb-install-ubuntu
RUN mv /usr/local/cwb-* /usr/local/cwb

###########################################
# Actual Image without build dependencies #
###########################################
FROM ubuntu:xenial

# Install dependency libraries
RUN apt-get update && \
    apt-get install -y \
    bison \
    flex \
    libglib2.0-0 \
    readline-common \
    && rm -rf /var/lib/apt/lists/*

# Add new binaries to PATH
COPY --from=builder /usr/local/cwb /usr/local/cwb
ENV PATH="/usr/local/cwb/bin/:${PATH}"

# To mount data storage
VOLUME /data

CMD ["bash"]
