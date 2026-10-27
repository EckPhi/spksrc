# Keep application data and credentials across package upgrades.
export XDG_CONFIG_HOME="${SYNOPKG_PKGVAR}/config"
export PATH="${SYNOPKG_PKGDEST}/bin:${PATH}"
export LD_LIBRARY_PATH="${SYNOPKG_PKGDEST}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
export RCLONE_MANAGER_DATA_DIR="${SYNOPKG_PKGVAR}/data"
export RCLONE_MANAGER_CACHE_DIR="${SYNOPKG_PKGVAR}/cache"
export RCLONE_MANAGER_LOG_DIR="${SYNOPKG_PKGVAR}/logs"
export RCLONE_MANAGER_HOST=0.0.0.0
export RCLONE_MANAGER_PORT="${SERVICE_PORT}"

# Read credentials as data, never as shell code or command-line arguments.
RCLONE_MANAGER_USER=
RCLONE_MANAGER_PASS=
if [ -r "${SYNOPKG_PKGVAR}/username" ] && [ -r "${SYNOPKG_PKGVAR}/password" ]; then
    RCLONE_MANAGER_USER=$(cat "${SYNOPKG_PKGVAR}/username")
    RCLONE_MANAGER_PASS=$(cat "${SYNOPKG_PKGVAR}/password")
    export RCLONE_MANAGER_USER RCLONE_MANAGER_PASS
fi

SERVICE_COMMAND="${SYNOPKG_PKGDEST}/bin/rclone-manager-server"
SVC_BACKGROUND=yes
SVC_WRITE_PID=yes

service_prestart()
{
    if [ -z "${RCLONE_MANAGER_USER:-}" ] || [ -z "${RCLONE_MANAGER_PASS:-}" ]; then
        echo "RClone Manager requires a username and password in ${SYNOPKG_PKGVAR}/username and ${SYNOPKG_PKGVAR}/password."
        exit 1
    fi
}

service_postinst()
{
    if [ "${SYNOPKG_PKG_STATUS}" = "INSTALL" ]; then
        if [ -z "${wizard_username}" ] || [ -z "${wizard_password}" ]; then
            echo "Administrator credentials are required."
            return 1
        fi
        (umask 077
         printf '%s' "${wizard_username}" > "${SYNOPKG_PKGVAR}/username"
         printf '%s' "${wizard_password}" > "${SYNOPKG_PKGVAR}/password")
    fi
}
