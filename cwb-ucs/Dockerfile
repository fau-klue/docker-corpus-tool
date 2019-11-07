FROM ubuntu:bionic as builder
ARG version="3.4.17"

# Install cwb dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
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
    libreadline7 \
    libreadline-dev \
    make \
    pkg-config \
    subversion \
    && rm -rf /var/lib/apt/lists/*

# Download latest sources
RUN svn co svn://svn.code.sf.net/p/cwb/code/cwb/trunk /cwb
RUN svn co svn://svn.code.sf.net/p/multiword/code/software/UCS/trunk /ucs
RUN svn co svn://svn.code.sf.net/p/cwb/code/perl/trunk cwb-perl

# Run install script and Move to unified location
WORKDIR /cwb
RUN ./install-scripts/install-linux
ENV PATH="/usr/local/ucs/System/bin/:/usr/local/cwb-${version}/bin/:${PATH}"

# Building the cwb-perl bridges and packing them
RUN cd /cwb-perl/CWB && perl Makefile.PL && make && make install DESTDIR=/binaries
RUN cd /cwb-perl/CWB-CL && perl Makefile.PL && make && make install DESTDIR=/binaries
RUN cd /cwb-perl/CWB-CQI && perl Makefile.PL && make && make install DESTDIR=/binaries
RUN cd /cwb-perl/CWB-Web && perl Makefile.PL && make && make install DESTDIR=/binaries
# This make copying the binaries easier
RUN tar cvf /binaries.tar /binaries/

###########################################
# Actual Image without build dependencies #
###########################################
FROM ubuntu:bionic
ARG version="3.4.17"

# Install dependency libraries
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
    a2ps \
    bison \
    cpanminus \
    make \
    flex \
    libglib2.0-0 \
    perl-doc \
    r-base-core \
    readline-common \
    libterm-readkey-perl \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies for ucs
RUN cpanm --force Statistics::R

# Add new binaries to PATH
COPY --from=builder /usr/local/cwb-* /usr/local/
COPY --from=builder /ucs /usr/local/ucs
COPY --from=builder /binaries.tar /

# Unpack the binaries to /usr
RUN tar xvf /binaries.tar --strip-components=1 && \
    rm -f /binaries.tar && \
    ln -s /usr/local/share/perl/$(perl -e 'print substr($^V, 1)')/CWB /usr/local/lib/site_perl && \
    mkdir -p "/usr/local/cwb-${version}" && \
    ln -s /usr/local/bin/ "/usr/local/cwb-${version}/bin"

# Install ucs and add new binaries to PATH
RUN perl /usr/local/ucs/System/Install.perl -f
ENV PATH="/usr/local/ucs/System/bin/:/usr/local/cwb-${version}/bin/:${PATH}"

# To mount data storage
VOLUME /data

CMD ["bash"]
