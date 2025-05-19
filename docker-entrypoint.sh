#!/bin/bash
set -e

# Generate app key if not set
php artisan key:generate --no-interaction --force

# Run migrations
php artisan migrate --force

# Cache configuration
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Additional commands as needed
php artisan storage:link