# RClone Manager

Packages the upstream standalone server (with embedded web assets and librclone)
for x86-64 and ARM64 NAS devices running DSM 7.2 or later. The release binaries
require GLIBC 2.34. D-Bus libraries and the Rclone command-line binary are bundled.

Open the DSM package shortcut or visit `http://NAS:8093`. The installation wizard
requires administrator credentials. Use DSM reverse proxy with HTTPS for remote
access; HTTP Basic Authentication alone does not encrypt credentials.

Application data, cache, logs and the `username` and `password` credential files
live under `/var/packages/rclone-manager/var` and survive upgrades. Credential
files are readable only by their owner. To change credentials, stop the package,
edit these files without changing their ownership or permissions, then restart.

Grant the system internal user `sc-rclone-manager` access to the required shared
folders using File Station. FUSE mounts are not configured by this package.
Use Package Center to update the application.

## Validation

Run `sh spk/rclone-manager/src/service-setup.test.sh` from the repository root.
Build with `make arch-x64-7.2` and `make arch-aarch64-7.2` from this directory in
the spksrc Linux container. Before submission, run `make all-supported` and test
fresh installation and reinstallation/upgrade on DSM hardware as required by
CONTRIBUTING.md.
