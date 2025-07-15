#!/bin/bash

set -e

echo "[$(date)] sync-debian-12.sh started" >> /var/log/sync.log

MIRROR_DIR="/var/www/html/debian-12"
REMOTE="rsync://ftp.debian.org/debian/"
DIST="bookworm"

mkdir -p "$MIRROR_DIR/dists"
mkdir -p "$MIRROR_DIR/pool"

echo "[$(date)] Syncing dists/$DIST ..." >> /var/log/sync.log
rsync -rtlH --delete-after --delay-updates --safe-links --progress \
  "${REMOTE}dists/$DIST" "$MIRROR_DIR/dists" >> /var/log/sync.log 2>&1

echo "[$(date)] Syncing pool/main ..." >> /var/log/sync.log
rsync -rtlH --delete-after --delay-updates --safe-links --progress \
  "${REMOTE}pool/main" "$MIRROR_DIR/pool/main" >> /var/log/sync.log 2>&1

echo "[$(date)] sync-debian-12.sh completed" >> /var/log/sync.log
