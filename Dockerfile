FROM php:8.3.3-apache

RUN apt-get update && apt-get install -y \
    libfreetype-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd  && docker-php-ext-install zip \
    && docker-php-ext-install mysqli && docker-php-ext-enable mysqli

CMD ["apache2-foreground"]
