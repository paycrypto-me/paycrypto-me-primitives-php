#!/usr/bin/env bash
# Shared runtime matrix for CI, setup and release. Update image pins here.
PHP_VERSIONS=(8.1 8.3)
PHP_IMAGES=(
    'php:8.1-cli-bookworm@sha256:482717722f08d9a6c2b4f98c40bfee6d7935bd1a17fef928881ecd5884dfd76e'
    'php:8.3-cli-bookworm@sha256:4687aec76c4a895b68b91bcd5e48f1ba7a3dea120f6de50bba7e1a93af5372dd'
)
DEV_PHP_VERSION=8.3

php_image() {
    local index
    for index in "${!PHP_VERSIONS[@]}"; do
        if [[ "${PHP_VERSIONS[index]}" == "$1" ]]; then
            printf '%s\n' "${PHP_IMAGES[index]}"
            return 0
        fi
    done
    echo "Unsupported development PHP version: $1" >&2
    return 1
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    set -euo pipefail
    [[ "${1:-}" == --matrix ]] || exit 1
    printf '{"include":['
    separator=''
    for index in "${!PHP_VERSIONS[@]}"; do
        printf '%s{"php":"%s","image":"%s"}' "$separator" "${PHP_VERSIONS[index]}" "${PHP_IMAGES[index]}"
        separator=,
    done
    printf ']}\n'
fi
