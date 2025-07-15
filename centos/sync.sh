#!/bin/bash
set -e

LOG="/var/log/sync.log"
BASE="/var/www/html/centos"
VAULT="rsync://archive.kernel.org/centos-vault/centos"
TIMEOUT=300  # 5-minute timeout per rsync

echo "[$(date)] sync.sh started" >> "$LOG"
mkdir -p "$BASE"/{5.0,6.10,7.0.1406}

for ver in 5.0 6.10 7.0.1406; do
  echo "[$(date)] Syncing CentOS $ver ..." >> "$LOG"
  timeout $TIMEOUT rsync -av --delete --delay-updates --safe-links \
    --verbose --progress "$VAULT/$ver/" "$BASE/$ver/" >> "$LOG" 2>&1 \
    && echo "[$(date)] Finished $ver" >> "$LOG" \
    || echo "[$(date)] **ERROR or timeout syncing $ver**" >> "$LOG"
done

echo "[$(date)] sync.sh finished" >> "$LOG"
