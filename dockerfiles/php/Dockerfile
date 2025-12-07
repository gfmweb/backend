# dockerfiles/php/Dockerfile
FROM php:8.4-fpm-alpine

# Установка необходимых системных зависимостей, включая $PHPIZE_DEPS для компиляции расширений
RUN apk update && apk add --no-cache \
    git \
    curl \
    libpq-dev \
    postgresql-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    $PHPIZE_DEPS \
    && docker-php-ext-install pdo pdo_pgsql opcache \
    # Установка Redis через PECL
    && pecl install -o -f redis \
    && docker-php-ext-enable redis \
    # Очистка: удаляем ненужные после сборки $PHPIZE_DEPS и кэш
    && apk del $PHPIZE_DEPS \
    && rm -rf /tmp/pear /var/cache/apk/*

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Установка рабочего каталога
WORKDIR /var/www/html

# Установка прав доступа
RUN chown -R www-data:www-data /var/www/html