ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

LABEL maintainer="Marco Guidolin <guidolin.marco94@gmail.com>"

# Replace sh binary with bash one (in order to source files and other cool stuff)
RUN mv /bin/sh /bin/sh.old && ln -s /bin/bash /bin/sh

# Install main libraries, software and php extensions
RUN mkdir -p /usr/share/man/{man1,man7} \
    && apt-get update \
    && apt-get install -y \
        apt-transport-https \
        bc \
        cron \
        supervisor \
        git \
        iproute2 \
        libxml2-dev \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libcurl4-gnutls-dev \
        libbz2-dev \
        libssl-dev \
        zlib1g-dev \
        gnupg2 \
        g++ \
        vim \
        python \
        libzip-dev \
        zip \
        gcc\
        automake \
        libtool \
        build-essential \
    && docker-php-ext-install opcache \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install zip \
    && docker-php-ext-install bz2 \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install exif

#######################
# MCRYPT INSTALLATION #
#######################
ARG ENABLE_MCRYPT_SUPPORT=false
RUN if [ ${ENABLE_MCRYPT_SUPPORT} = true ] ; then \
    if [ $(bc -l<<<"${PHP_VERSION:0:3} >= 7.0") == $(bc -l<<<"${PHP_VERSION:0:3} < 7.2") ] ; then \
        apt-get install -yqq \
            libonig-dev \
            libmcrypt-dev \
        && docker-php-ext-install mcrypt \
    ; elif [ $(bc -l<<<"${PHP_VERSION:0:3} >= 7.2") == $(bc -l<<<"${PHP_VERSION:0:3} < 8.0") ] ; then \
        apt-get install -yqq \
            libonig-dev \
            libmcrypt-dev \
        && pecl install mcrypt-1.0.4 \
        && docker-php-ext-enable mcrypt \
    ;fi \
;fi

######################
# MYSQL INSTALLATION #
######################
ARG DBMS
RUN if [ ${DBMS} = mysql ]; then \
    docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
;fi

######################
# PGSQL INSTALLATION #
######################
RUN if [ ${DBMS} = postgresql ]; then \
    apt-get install -y \
        postgresql-client \
        libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pgsql \
    && docker-php-ext-install pdo_pgsql \
;fi

#######################
# XDEBUG INSTALLATION #
#######################
ARG ENABLE_XDEBUG_SUPPORT=false
ARG XD_REMOTE_HOST=host.docker.internal
ARG XD_IDEKEY=PHPSTORM
ARG XD_REMOTE_PORT
RUN if [ ${ENABLE_XDEBUG_SUPPORT} = true ]; then \
    if [ $(bc -l<<<"${PHP_VERSION:0:3} < 7.1") -eq 1 ] ; then \
        printf 'Installing xdebug 2.8.0 \n' \
        && pecl install xdebug-2.8.0 \
        && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_host=$XD_REMOTE_HOST" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_port=$XD_REMOTE_PORT" >> /usr/local/etc/php/conf.d/xdebug.ini \
    ; elif [ $(bc -l<<<"${PHP_VERSION:0:3} < 7.2") -eq 1 ] ; then \
        printf 'Installing xdebug 2.9.8 \n' \
        && pecl install xdebug-2.9.8 \
        && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_host=$XD_REMOTE_HOST" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_port=$XD_REMOTE_PORT" >> /usr/local/etc/php/conf.d/xdebug.ini \
    ; else \
        printf 'Installing latest xdebug \n' \
        && pecl install xdebug \
        && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.client_host=$XD_REMOTE_HOST" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.client_port=$XD_REMOTE_PORT" >> /usr/local/etc/php/conf.d/xdebug.ini \
    ;fi \
    && touch /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=$XD_IDEKEY" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && docker-php-ext-enable xdebug \
;fi

############################
# IMAGEMAGICK INSTALLATION #
############################
ARG ENABLE_IMAGIC_SUPPORT=false
RUN if [ ${ENABLE_IMAGIC_SUPPORT} = true ]; then \
    apt-get install -y libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
;fi

##########################
# PHP REDIS INSTALLATION #
##########################
ARG ENABLE_PHPREDIS_SUPPORT=false
RUN if [ ${ENABLE_PHPREDIS_SUPPORT} = true ]; then \
    pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis \
;fi

#####################
# INTL INSTALLATION #
#####################
ARG ENABLE_INTL_SUPPORT=false
RUN if [ ${ENABLE_INTL_SUPPORT} = true ]; then \
    apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
;fi

##############################
# Cleanup installation cache #
##############################
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean

##############################
# Syncronize custom settings #
##############################
COPY conf/php/php.ini /usr/local/etc/php/
COPY conf/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY conf/.bashrc /root/.bashrc
RUN sed -i 's/\r//' /root/.bashrc

####################
# Install Composer #
####################
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer
ENV PATH="/usr/local/bin:$PATH"

##################################
# Laravel Installer installation #
##################################
ARG ENABLE_LARAVEL_INSTALLER=false
RUN if [ ${ENABLE_LARAVEL_INSTALLER} = true ]; then \
    composer global require "laravel/installer" \
;fi

##############################
# NODEJS support through NVM #
##############################
ARG PREFERRED_NODE_VERSION=stable
ARG ENABLE_NODEJS_SUPPORT=false
RUN if [ ${ENABLE_NODEJS_SUPPORT} = true ]; then \
    curl -o - https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash \
    && source $HOME/.nvm/nvm.sh \
    && nvm --version \
    && nvm install stable \
    && nvm install ${PREFERRED_NODE_VERSION} \
;fi

########################################
# Handle SSL certificates and SSH keys #
########################################
RUN usermod -u 1000 www-data \
    && mkdir -p /root/.ssh \
    && mkdir -p /etc/ssl/certificates

COPY ssl-certificates /etc/ssl/certificates/
COPY ssh-keys/ /root/.ssh/


RUN if [ $(ls -1 /etc/ssl/certificates/*.crt 2>/dev/null | wc -l) != 0 ]; then \
    chmod -R 644 /etc/ssl/certificates/* \
;fi

RUN if [ $(ls -1 /root/.ssh/id_rsa* 2>/dev/null | wc -l) != 0 ]; then \
    chmod 600 /root/.ssh/id_rsa \
    && chmod 644 /root/.ssh/id_rsa.pub \
;fi

######################
# Register cron jobs #
######################
COPY cron-jobs/* /etc/cron.d/
RUN if [ $(ls -1 /etc/cron.d/*.job 2>/dev/null | wc -l) != 0 ]; then \
    for JOB_FILE in /etc/cron.d/*.job ; \
    do \
        chmod 644 ${JOB_FILE} ; \
        cat ${JOB_FILE} | crontab - ; \
    done \
;fi

############################
# Register supervisor jobs #
############################
COPY conf/supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisor-programs/* /etc/supervisor/conf.d/
RUN mkdir -p /var/www/logs/supervisor
RUN if [ $(ls -1 /etc/supervisor/conf.d/*.conf 2>/dev/null | wc -l) != 0 ]; then \
    for SUPERVISOR_PROGRAM in /etc/supervisor/conf.d/*.conf ; \
    do \
        echo "" >> /etc/supervisor/supervisord.conf ; \
        cat ${SUPERVISOR_PROGRAM} >> /etc/supervisor/supervisord.conf ; \
    done \
;fi

CMD ["/usr/bin/supervisord"]
