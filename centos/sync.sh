#!/bin/bash

set -e

echo "[$(date)] sync.sh started" >> /var/log/sync.log

BASE_DIR="/var/www/html/centos"
VAULT="rsync://vault.centos.org"

mkdir -p "$BASE_DIR"

# Sync CentOS 5.0
rsync -rtlH --delete-after --delay-updates --safe-links --progress \
  "$VAULT/5.0/" "$BASE_DIR/5.0/" >> /var/log/sync.log 2>&1

# Sync CentOS 6.10
rsync -rtlH --delete-after --delay-updates --safe-links --progress \
  "$VAULT/6.10/" "$BASE_DIR/6.10/" >> /var/log/sync.log 2>&1

# Sync CentOS 7.0.1406 (initial release of 7.x)
rsync -rtlH --delete-after --delay-updates --safe-links --progress \
  "$VAULT/7.0.1406/" "$BASE_DIR/7.0.1406/" >> /var/log/sync.log 2>&1

echo "[$(date)] sync.sh finished" >> /var/log/sync.log
