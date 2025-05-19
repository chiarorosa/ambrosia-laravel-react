#!/bin/bash
set -e

# Create .env file from environment variables
echo "APP_NAME=\"${APP_NAME:-Ambrosia}\"" > .env
echo "APP_ENV=${APP_ENV:-production}" >> .env

# Configuração Render.com
if [ "${RENDER:-false}" = "true" ]; then
  echo "APP_ENV=production" >> .env
else
  echo "APP_ENV=${APP_ENV:-local}" >> .env
fi

echo "APP_KEY=" >> .env
echo "APP_DEBUG=${APP_DEBUG:-true}" >> .env
echo "APP_URL=${APP_URL:-http://localhost}" >> .env

echo "LOG_CHANNEL=${LOG_CHANNEL:-stack}" >> .env
echo "LOG_LEVEL=${LOG_LEVEL:-debug}" >> .env

# Configuração para SQLite
echo "DB_CONNECTION=${DB_CONNECTION:-sqlite}" >> .env
echo "DB_DATABASE=${DB_DATABASE:-/var/www/html/database/database.sqlite}" >> .env

# Configurar cache para usar o filesystem em vez do banco de dados
echo "CACHE_DRIVER=file" >> .env
echo "SESSION_DRIVER=file" >> .env
echo "QUEUE_CONNECTION=sync" >> .env

# Verificar permissões do arquivo .env
chmod 666 .env

# Criar arquivo SQLite se não existir
if [ "$DB_CONNECTION" = "sqlite" ] || [ -z "$DB_CONNECTION" ]; then
    echo "Usando SQLite como banco de dados"
    mkdir -p database
    touch database/database.sqlite
    chmod 666 database/database.sqlite
fi

# Generate app key - forçar a geração e atualizar no arquivo .env
echo "Gerando chave da aplicação..."
php artisan key:generate --force
echo "Chave gerada: $(grep APP_KEY .env)"

# Run migrations before clearing cache
echo "Executando migrações..."
php artisan migrate --force

# Clear caches after migrations are done
echo "Limpando caches do Laravel..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan optimize:clear

# Additional commands as needed
php artisan storage:link

# Cache configuration for production (opcional)
# php artisan config:cache
# php artisan route:cache