# Build stage para WordPress
FROM php:8.1-fpm-alpine as wordpress-builder

# Instalar dependências necessárias
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    mysql-client \
    zip \
    unzip

# Instalar extensões PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql

WORKDIR /var/www/html

# Copiar WordPress
COPY html/ .
COPY .env .

# Configurar permissões
RUN chown -R www-data:www-data /var/www/html

# Stage final com Nginx
FROM nginx:alpine

# Instalar PHP-FPM no Nginx
RUN apk add --no-cache \
    php81-fpm \
    php81-mysqli \
    php81-pdo_mysql \
    php81-gd \
    php81-dom \
    php81-curl \
    php81-json \
    php81-xml \
    php81-mbstring \
    php81-simplexml

# Copiar arquivos do WordPress
COPY --from=wordpress-builder /var/www/html /var/www/html

# Copiar configuração do Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Criar diretório necessário
RUN mkdir -p /var/run/php-fpm

# Exposar portas
EXPOSE 80 443

# Comando para iniciar both Nginx e PHP-FPM
CMD ["sh", "-c", "php-fpm81 -D && nginx -g 'daemon off;'"]
