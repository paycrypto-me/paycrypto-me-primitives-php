#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/php-images.sh

if (($# > 1)); then
    echo 'Usage: bash scripts/setup.sh [PHP_VERSION]' >&2
    exit 1
fi
image=$(php_image "${1:-$DEV_PHP_VERSION}")
docker compose build --build-arg "PHP_IMAGE=$image" app
docker compose run --rm --user "$(id -u):$(id -g)" \
    -e COMPOSER_HOME=/tmp/composer app sh -c \
    'composer install --no-interaction --prefer-dist && composer ci'
