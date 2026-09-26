#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/php-images.sh

usage() {
    echo 'Usage: bash scripts/release.sh -v X.Y.Z [--git] [--push] [--dry-run]'
    echo 'Default: validate only. --git creates an annotated tag; --push also pushes it.'
}
version=''
tag_release=0
push_release=0
dry_run=0
while (($#)); do
    case "$1" in
        -v) version="${2:?Missing version}"; shift 2 ;;
        --git) tag_release=1; shift ;;
        --push) push_release=1; tag_release=1; shift ;;
        --dry-run) dry_run=1; shift ;;
        -h|--help) usage; exit 0 ;;
        *) usage >&2; exit 1 ;;
    esac
done
[[ "$version" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]] || { usage >&2; exit 1; }
test -z "$(git status --porcelain)" || { echo 'Commit all changes before releasing.' >&2; exit 1; }
branch=$(git symbolic-ref --quiet --short HEAD)
[[ "$branch" == main ]] || { echo 'Release must run from main.' >&2; exit 1; }
if git show-ref --verify --quiet "refs/tags/v$version"; then
    echo "Tag v$version already exists." >&2
    exit 1
fi
revision=$(git rev-parse HEAD)
echo "Release v$version from $branch at $revision"
if ((dry_run)); then
    echo "Would verify docs/archive and run Composer CI in isolated PHP ${PHP_VERSIONS[*]} containers."
    ((tag_release == 0)) || echo "Would create annotated tag v$version."
    ((push_release == 0)) || echo "Would push main and v$version to origin; operator must verify Packagist indexing."
    exit 0
fi
bash scripts/check-release.sh

# Each runtime gets its own checkout/vendor tree; validation never changes the
# developer's installed dependencies or creates root-owned files in the repo.
release_tmp=$(mktemp -d /tmp/primitives-release.XXXXXX)
trap 'rm -rf "$release_tmp"' EXIT
for php_version in "${PHP_VERSIONS[@]}"; do
    checkout="$release_tmp/php-$php_version"
    # A checkout preserves modes and symlinks and includes test tooling excluded
    # from distribution archives. Build only the revision that will be tagged.
    git clone --quiet --local --no-hardlinks . "$checkout"
    git -C "$checkout" checkout --quiet --detach "$revision"
    docker build --build-arg "PHP_IMAGE=$(php_image "$php_version")" \
        -t "paycrypto-me-primitives:release-$php_version" "$checkout"
    docker run --rm --user "$(id -u):$(id -g)" \
        -e COMPOSER_HOME=/tmp/composer -v "$checkout:/workspace" \
        "paycrypto-me-primitives:release-$php_version" sh -c \
        'composer install --no-interaction --prefer-dist && composer ci'
done
test "$(git rev-parse HEAD)" = "$revision"
test -z "$(git status --porcelain)"
if ((tag_release)); then
    git tag -a "v$version" -m "Release v$version" "$revision"
fi
if ((push_release)); then
    git push --atomic origin main "refs/tags/v$version"
fi
echo "Validated v$version at $revision."
echo "Verify indexing at https://packagist.org/packages/paycrypto-me/primitives (requires repository registration/webhook)."
