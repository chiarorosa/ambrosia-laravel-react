#!/bin/bash
set -e

# Create .env file from environment variables
echo "APP_NAME=\"${APP_NAME:-Ambrosia}\"" > .env
echo "APP_ENV=${APP_ENV:-production}" >> .env
echo "APP_KEY=${APP_KEY:-}" >> .env
echo "APP_DEBUG=${APP_DEBUG:-false}" >> .env
echo "APP_URL=${APP_URL:-http://localhost}" >> .env

echo "LOG_CHANNEL=${LOG_CHANNEL:-stack}" >> .env
echo "LOG_LEVEL=${LOG_LEVEL:-error}" >> .env

# Configuração para SQLite
echo "DB_CONNECTION=${DB_CONNECTION:-sqlite}" >> .env
echo "DB_DATABASE=${DB_DATABASE:-/var/www/html/database/database.sqlite}" >> .env

# Generate app key if not set
if [ -z "$APP_KEY" ]; then
    php artisan key:generate --no-interaction
else
    echo "APP_KEY already set"
fi

# Criar arquivo SQLite se não existir
if [ "$DB_CONNECTION" = "sqlite" ] || [ -z "$DB_CONNECTION" ]; then
    echo "Usando SQLite como banco de dados"
    touch database/database.sqlite
    chmod 666 database/database.sqlite
fi

# Clear all caches before starting
echo "Limpando caches do Laravel..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear
php artisan optimize:clear

# Run migrations
php artisan migrate --force

# Cache configuration
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Additional commands as needed
php artisan storage:link