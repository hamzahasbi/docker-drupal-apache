FROM php:7.4-fpm
LABEL maintainer="hamza.hasbi@gmail.com"

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    g++ \
    time \
    git \
    libjudy-dev\
    libbz2-dev \
    libc-client-dev \
    libcurl4-gnutls-dev \
    libedit-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libkrb5-dev \
    libldap2-dev \
    libldb-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng-dev \
    libpq-dev \
    libsqlite3-dev \
    libssl-dev \
    libonig-dev \
    libtidy-dev \
    libreadline-dev \
    libxslt1-dev \
    libzip-dev \
    memcached \
    wget \
    unzip \
    zlib1g-dev \
    && docker-php-ext-install -j$(nproc) \
    mbstring \
    xsl \
    intl \
    exif \
    ftp \
    zip \
    bcmath \
    bz2 \
    calendar \
    exif \
    gettext \
    mysqli \
    opcache \
    pdo_mysql \
    pdo_pgsql \
    tidy \
    pgsql \
    soap \
    sockets \
    xsl \
    && apt-get -y --no-install-recommends install msmtp \
    && apt-get -y --no-install-recommends install mariadb-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install ldap \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    # && pecl install xdebug && docker-php-ext-enable xdebug \
    # && pecl install xmlrpc && docker-php-ext-enable xmlrpc \
    && pecl install xhprof && docker-php-ext-enable xhprof \
    && pecl install memprof && docker-php-ext-enable memprof \
    && pecl install memcached && docker-php-ext-enable memcached \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && pecl install redis && docker-php-ext-enable redis \
    && yes '' | pecl install imagick && docker-php-ext-enable imagick \
    && pecl install apcu && docker-php-ext-enable apcu \
    && pecl install uploadprogress && docker-php-ext-enable uploadprogress \
    && echo "apc.enable_cli=1\n"  \
            "apc.enable=1\n" \
            "apc.shm_size=64M" > /usr/local/etc/php/conf.d/apc.ini \
    && docker-php-source delete \
    && cd /usr/src \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --version=1.10.14 && mv composer.phar /usr/local/bin/composer \
    && wget -O drush.phar "https://github.com/drush-ops/drush-launcher/releases/tag/0.10.1/drush.phar" \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush \
    && cd /usr/src \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --version=2.1.6 && mv composer.phar /usr/local/bin/composer2 \
    && composer global require "drush/drush:9.7.3" \
    && php -r "readfile('https://drupalconsole.com/installer');" > drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal \
    && composer2 global require drupal/console \
    && apt-get remove -y g++ wget \
    && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && architecture=$(uname -m) \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/$architecture/$version \
    && mkdir -p /tmp/blackfire \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire-*.so $(php -r "echo ini_get ('extension_dir');")/blackfire.so \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz
# ADD xdebug.ini  $PHP_INI_DIR/conf.d
ADD blackfire.ini  $PHP_INI_DIR/conf.d

ADD maxsize.ini /usr/local/etc/php/conf.d/maxsize.ini

RUN chown -R www-data:www-data $HOME/.composer/
WORKDIR /var/www/html
ENV PATH="/root/.composer/vendor/bin:$PATH"
ENV PATH="/var/www/html/vendor/bin:$PATH"

