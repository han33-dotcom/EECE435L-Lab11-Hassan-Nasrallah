#!/bin/sh
set -eu

repo=$(CDPATH='' cd -- "$(dirname -- "$0")/../.." && pwd)
cd "$repo"

if [ "$(dpkg --print-architecture)" != amd64 ]; then
    printf '%s\n' 'An amd64 Debian build environment is required.' >&2
    exit 1
fi

stage=$(mktemp -d)
trap 'rm -rf -- "$stage"' EXIT
chmod 0755 "$stage"
mkdir -p dist
install -d "$stage/DEBIAN" "$stage/usr/local/bin" "$stage/usr/share/doc/helloworld-hassan-nasrallah"

printf '%s\n' 'gcc -std=c17 -O2 -Wall -Wextra -Werror -pedantic src/linux/helloworld.c'
gcc -std=c17 -O2 -Wall -Wextra -Werror -pedantic -o "$stage/usr/local/bin/helloworld" src/linux/helloworld.c
install -m 0644 packaging/debian/control "$stage/DEBIAN/control"
install -m 0644 README.md docs/user_guide.txt "$stage/usr/share/doc/helloworld-hassan-nasrallah/"

package=dist/helloworld_Hassan_Nasrallah.deb
printf 'dpkg-deb --build --root-owner-group <staging-directory> %s\n' "$package"
dpkg-deb --build --root-owner-group "$stage" "$package"
printf 'Built %s\n' "$package"
