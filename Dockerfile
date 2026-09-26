# The development image intentionally contains only PHP and Composer tooling.
# This package is a standalone library: it has no web server, database, or
# WordPress runtime.
# Deliberate digest pins make a local rebuild and CI use the same toolchain
# until this file is consciously updated.
FROM composer:2@sha256:9715c7f69044da2a212a5fbde29ee7da24e364d426560ae6367b060236f847d7 AS composer

FROM php:8.3-cli-bookworm@sha256:4687aec76c4a895b68b91bcd5e48f1ba7a3dea120f6de50bba7e1a93af5372dd

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

RUN apt-get update \
    && apt-get install --yes --no-install-recommends git unzip \
    && rm -rf /var/lib/apt/lists/*

# Match the usual host developer UID to keep bind-mounted vendor/ writable.
RUN groupadd --gid 1000 app \
    && useradd --uid 1000 --gid app --create-home --shell /bin/bash app

USER app
WORKDIR /workspace

CMD ["composer", "ci"]
