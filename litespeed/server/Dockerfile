FROM litespeedtech/openlitespeed:1.7.14-lsphp74
LABEL maintainer="hamza.hasbi@gmail.com"
RUN cd /usr/src \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --version=1.10.14 && mv composer.phar /usr/local/bin/composer \
    && wget -O drush.phar "https://github.com/drush-ops/drush-launcher/releases/download/0.8.0/drush.phar" \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush \
    && cd /usr/src \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --version=2.1.6 && mv composer.phar /usr/local/bin/composer2 \
    && wget -O drush.phar "https://github.com/drush-ops/drush-launcher/releases/download/0.8.0/drush.phar" \
    && chmod +x drush.phar \
    && mv drush.phar /usr/local/bin/drush \
    && composer global require "drush/drush:9.7.3" \
    && apt-get remove -y g++ wget \
    && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

ADD maxsize.ini /usr/local/lsws/lsphp74/etc/php/7.4/mods-available/maxsize.ini

ENV PATH="/root/.composer/vendor/drush/drush:$PATH"
