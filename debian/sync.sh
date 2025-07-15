#!/bin/bash

set -e

echo "[$(date)] sync.sh started" >> /var/log/sync.log

MIRROR_DIR="/var/www/html/debian"
REMOTE="rsync://ftp.de.debian.org/debian"

mkdir -p "$MIRROR_DIR/dists"
mkdir -p "$MIRROR_DIR/pool"

rsync -a --delete --progress \
  rsync://ftp.de.debian.org/debian/ /var/www/html/debian/

# Sync the package pool
rsync -a --delete --progress \
  "$REMOTE/pool/" "$MIRROR_DIR/pool/" >> /var/log/sync.log 2>&1

echo "[$(date)] sync.sh finished" >> /var/log/sync.log
