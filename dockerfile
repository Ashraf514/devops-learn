FROM php:8.0-fpm-alpine
RUN apk add --no-cache nginx unzip libzip-dev \
    && docker-php-ext-install zip
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
WORKDIR /app
COPY . .
RUN composer install --no-dev --optimize-autoloader

COPY nginx.conf /etc/nginx/nginx.conf

# EXPOSE 8001
# CMD [ "php", "-S","0.0.0.0:8001","-t","public" ]
EXPOSE 80

CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]