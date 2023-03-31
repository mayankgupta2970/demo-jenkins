FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y nginx wget


RUN apt-get install -y \
    apache2-utils \
    libapache2-mod-php \
    libgd-dev \
    libjpeg-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    php \
    php-cli \
    php-curl \
    php-gd \
    php-intl \
    php-mbstring \
    php-mysql \
    php-xml \
    php-zip \
    unzip

RUN wget https://downloads.joomla.org/cms/joomla3/3-10-2/joomla_3-10-2-stable-full_package.zip -O /tmp/joomla.zip \
    && unzip /tmp/joomla.zip -d /var/www/html \
    && chown -R www-data:www-data /var/www/html


COPY nginx.conf /etc/nginx/nginx.conf


EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]
