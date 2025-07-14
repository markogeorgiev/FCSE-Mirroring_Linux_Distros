#!/bin/bash

set -e

echo "[$(date)] sync.sh started" >> /var/log/sync.log

MIRROR_DIR="/var/www/html/debian-11"
REMOTE="rsync://ftp.debian.org/debian/"

mkdir -p "$MIRROR_DIR"
rsync -rtlH --delete-after --delay-updates --safe-links --progress "$REMOTE" "$MIRROR_DIR" >> /var/log/sync.log 2>&1
