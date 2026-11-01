#!/bin/sh
# Run with: sh spk/rclone-manager/src/service-setup.test.sh
set -eu
setup="$(cd "$(dirname "$0")" && pwd)/service-setup.sh"
test_dir=$(mktemp -d)
trap 'rm -rf "$test_dir"' EXIT HUP INT TERM
export SYNOPKG_PKGVAR="$test_dir/var"
export SYNOPKG_PKGDEST="$test_dir/target"
export SERVICE_PORT=8093
mkdir -p "$SYNOPKG_PKGVAR"
. "$setup"

# An unconfigured installation must never start without authentication.
if (service_prestart); then
    echo "Unexpected unauthenticated start" >&2
    exit 1
fi
SYNOPKG_PKG_STATUS=INSTALL
wizard_username=admin
wizard_password='spaces " quotes $dollar `backticks` ; $(touch injected)'
wizard_password="${wizard_password}'"
service_postinst
[ "$(cat "$SYNOPKG_PKGVAR/password")" = "$wizard_password" ]
[ "$(ls -l "$SYNOPKG_PKGVAR/password" | cut -c1-10)" = "-rw-------" ]
. "$setup"
service_prestart
[ "$RCLONE_MANAGER_PASS" = "$wizard_password" ]
[ "$RCLONE_MANAGER_USER" = admin ]
[ "$RCLONE_MANAGER_PORT" = 8093 ]
[ "$RCLONE_MANAGER_DATA_DIR" = "$SYNOPKG_PKGVAR/data" ]
[ ! -e injected ]

# Upgrade preserves credentials; fresh installs reject empty input.
SYNOPKG_PKG_STATUS=UPGRADE
wizard_password=replacement
service_postinst
[ "$(cat "$SYNOPKG_PKGVAR/password")" = "$RCLONE_MANAGER_PASS" ]
SYNOPKG_PKG_STATUS=INSTALL
wizard_password=
if service_postinst; then
    echo "Unexpected acceptance of empty credentials" >&2
    exit 1
fi
wizard_password=valid-password
wizard_username=
if service_postinst; then
    echo "Unexpected acceptance of an empty username" >&2
    exit 1
fi
printf '%s' '' > "$SYNOPKG_PKGVAR/password"
. "$setup"
if (service_prestart); then
    echo "Unexpected acceptance of an empty password file" >&2
    exit 1
fi
rm "$SYNOPKG_PKGVAR/password"
RCLONE_MANAGER_USER=ambient-user
RCLONE_MANAGER_PASS=ambient-password
. "$setup"
if (service_prestart); then
    echo "Unexpected use of ambient credentials with missing files" >&2
    exit 1
fi
echo "Service setup tests passed"
