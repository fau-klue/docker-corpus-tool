FROM debian:stretch as builder

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

# Download latest cwb source
RUN svn co http://svn.code.sf.net/p/cwb/code/cwb/trunk /cwb

# Run install script and Move to unified location
WORKDIR /cwb
RUN ./install-scripts/install-linux
RUN mv /usr/local/cwb-* /usr/local/cwb

###########################################
# Actual Image without build dependencies #
###########################################
FROM php:apache-stretch

# Install dependency libraries
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
    bison \
    flex \
    libglib2.0-0 \
    libpng-dev \
    libzip-dev \
    readline-common \
    r-base \
    && rm -rf /var/lib/apt/lists/*

# Install PHP Plugins
RUN set -ex; \
        docker-php-ext-install -j5 \
        gd \
        pdo \
        pdo_mysql \
        zip

# Add new binaries to PATH
COPY --from=builder /usr/local/cwb /usr/local/cwb
ENV PATH="/usr/local/cwb/bin/:${PATH}"

# Download, unzip and chmod CQPWeb from official repository
ADD "https://downloads.sourceforge.net/project/cwb/CQPweb/CQPweb-3.2/CQPweb-3.2.30.tar.gz?r=&amp;ts=1558358297&amp;use_mirror=liquidtelecom" /tmp

RUN set -ex; \
        \
        tar xzvf "/tmp/CQPweb-3.2.30.tar.gz" --strip-components=1 -C /var/www/html/ && \
        rm -f "/tmp/CQPweb-3.2.30.tar.gz" && \
        chown -R www-data:www-data /var/www/html

# Copy CQPWeb configuration
COPY config.inc.php /var/www/html/lib/
COPY entrypoint.sh /entrypoint.sh

# To mount data storage
VOLUME /data

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
