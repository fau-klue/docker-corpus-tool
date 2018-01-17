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

# Download latest sources
RUN svn co http://svn.code.sf.net/p/cwb/code/cwb/trunk /cwb
RUN svn co svn://svn.code.sf.net/p/multiword/code/software/UCS/trunk /ucs

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
    apt-get install --no-install-recommends -y \
    a2ps \
    bison \
    cpanminus \
    flex \
    libglib2.0-0 \
    perl-doc \
    r-base-core \
    readline-common \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies for ucs
RUN cpanm Term::ReadKey \
    Statistics::R

# Add new binaries to PATH
COPY --from=builder /usr/local/cwb /usr/local/cwb
COPY --from=builder /ucs /usr/local/ucs

# Install ucs and add new binaries to PATH
RUN perl /usr/local/ucs/System/Install.perl -f
ENV PATH="/usr/local/ucs/System/bin/:/usr/local/cwb/bin/:${PATH}"

# To mount data storage
VOLUME /data

CMD ["bash"]
