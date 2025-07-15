#!/bin/bash

set -e

echo "[$(date)] sync.sh started" >> /var/log/sync.log

MIRROR_DIR="/var/www/html/debian"
REMOTE="rsync://ftp.de.debian.org/debian"

mkdir -p "$MIRROR_DIR/dists"
mkdir -p "$MIRROR_DIR/pool"

# Sync only dists for Debian 11 and 12
rsync -a --delete --progress \
  --include="bookworm*/" \
  --include="bullseye*/" \
  --include="README*" \
  --exclude="*" \
  "$REMOTE/dists/" "$MIRROR_DIR/dists/" >> /var/log/sync.log 2>&1

# Sync the package pool
rsync -a --delete --progress \
  "$REMOTE/pool/" "$MIRROR_DIR/pool/" >> /var/log/sync.log 2>&1

echo "[$(date)] sync.sh finished" >> /var/log/sync.log
