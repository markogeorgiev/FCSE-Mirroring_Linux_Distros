#!/bin/bash
set -e

LOG="/var/log/sync.log"
BASE="/var/www/html/centos"
VAULT="rsync://archive.kernel.org/centos-vault"

echo "[$(date)] sync.sh started" >> "$LOG"
mkdir -p "$BASE/5.0" "$BASE/6.10" "$BASE/7.0.1406"

for ver in 5.0 6.10 7.0.1406; do
  echo "[$(date)] Syncing CentOS $ver" >> "$LOG"

  rsync -a --delete --delay-updates --safe-links --progress \
    "$VAULT/$ver/" "$BASE/$ver/" >> "$LOG" 2>&1 \
    || {
      echo "[$(date)] ERROR syncing $ver" >> "$LOG"
    }
done

echo "[$(date)] sync.sh finished" >> "$LOG"
