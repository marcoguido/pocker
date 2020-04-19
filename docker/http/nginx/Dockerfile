ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

LABEL maintainer="Marco Guidolin <guidolin.marco94@gmail.com>"

# Install OpenSSL
RUN apt-get update \
    && apt-get install -y openssl vim \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Define Nginx working directory
WORKDIR /var/www/html

# Define some user details, create a logging
# directory and one for ssl certificates
RUN usermod -u 1000 www-data \
    && mkdir -p /var/www/logs/nginx/ \
    && mkdir -p /etc/ssl/certificates/

# Expose HTTP and HTTPS ports
EXPOSE 80
EXPOSE 443
