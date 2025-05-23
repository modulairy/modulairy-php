FROM php:8.3.19-apache

ENV MAKEFLAGS="-j2"
ENV CXXFLAGS="-O1"

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libwebp-dev \
    libpng-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp\
    && docker-php-ext-install gd  && docker-php-ext-install zip \
    && docker-php-ext-install mysqli && docker-php-ext-enable mysqli \
    && docker-php-ext-install pdo_mysql  

RUN docker-php-ext-enable zip mysqli 

RUN apt install -y git
RUN apt install -y vim
RUN apt install -y curl
RUN apt install -y unzip
RUN apt-get install libsodium-dev -y && docker-php-ext-install sodium
RUN apt install -y libgd-dev 
RUN  apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl


RUN curl -O https://getcomposer.org/installer && php installer && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

CMD ["apache2-foreground"]
