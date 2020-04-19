ARG APACHE_VERSION=latest
FROM httpd:$APACHE_VERSION

LABEL maintainer="Marco Guidolin <guidolin.marco94@gmail.com>"

# Install OpenSSL
RUN apt-get update \
    && apt-get install -y openssl vim \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Copying Apache override files
COPY conf/config-override.conf /usr/local/apache2/conf/
COPY conf/dir.conf /usr/local/apache2/conf/
COPY conf/ssl.conf /usr/local/apache2/conf/extra/
COPY conf/virtualhosts.conf /usr/local/apache2/conf/extra/

# Make sure to load every virtual host file
ARG ENABLE_SSL=false
RUN echo "Include /usr/local/apache2/conf/config-override.conf" >> /usr/local/apache2/conf/httpd.conf \
    && mkdir -p /usr/local/apache2/conf/virtualhosts \
    if [ ${ENABLE_SSL} = true ] ; then \
        echo "Include /usr/local/apache2/conf/extra/ssl.conf" >> /usr/local/apache2/conf/httpd.conf \
    ;fi

# Define some user details and create a logging directory
RUN usermod -u 1000 www-data \
    && mkdir -p /var/www/logs/apache/

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443
