FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    curl \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js and npm (latest LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel installer globally
RUN composer global require laravel/installer

ENV PATH="${PATH}:/root/.composer/vendor/bin"

# Copy supervisor and startup configs
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start-vite.sh /usr/local/bin/start-vite.sh
RUN chmod +x /usr/local/bin/start-vite.sh

WORKDIR /workspace

EXPOSE 9000 5173

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
