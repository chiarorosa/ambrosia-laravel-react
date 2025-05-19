#!/bin/bash
set -e

# Create .env file from environment variables
echo "APP_NAME=\"${APP_NAME:-Ambrosia}\"" > .env
echo "APP_ENV=${APP_ENV:-production}" >> .env
# Deixar APP_KEY vazio inicialmente para gerar uma nova
echo "APP_KEY=" >> .env
echo "APP_DEBUG=${APP_DEBUG:-true}" >> .env  # Temporariamente true para depuração
echo "APP_URL=${APP_URL:-http://localhost}" >> .env

echo "LOG_CHANNEL=${LOG_CHANNEL:-stack}" >> .env
echo "LOG_LEVEL=${LOG_LEVEL:-debug}" >> .env  # Temporariamente debug para ver mais detalhes

# Configuração para SQLite
echo "DB_CONNECTION=${DB_CONNECTION:-sqlite}" >> .env
echo "DB_DATABASE=${DB_DATABASE:-/var/www/html/database/database.sqlite}" >> .env

# Verificar permissões do arquivo .env
chmod 666 .env

# Criar arquivo SQLite se não existir
if [ "$DB_CONNECTION" = "sqlite" ] || [ -z "$DB_CONNECTION" ]; then
    echo "Usando SQLite como banco de dados"
    mkdir -p database
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

# Generate app key - forçar a geração e atualizar no arquivo .env
echo "Gerando chave da aplicação..."
php artisan key:generate --force
# Verificar se a chave foi gerada
echo "Chave gerada: $(grep APP_KEY .env)"

# Run migrations
php artisan migrate --force

# Cache configuration (somente após garantir que tudo está funcionando)
# php artisan config:cache
# php artisan route:cache
# php artisan view:cache

# Additional commands as needed
php artisan storage:link