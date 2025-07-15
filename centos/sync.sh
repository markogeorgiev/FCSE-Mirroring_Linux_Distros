#!/bin/bash

set -e

LOG="/var/log/sync.log"
BASE="/var/www/html/centos"
VAULT="rsync://archive.kernel.org/centos-vault"

echo "[$(date)] sync.sh started" >> "$LOG"

mkdir -p "$BASE/5.0" "$BASE/6.10" "$BASE/7.0.1406"

rsync -rtlH --delete-after --delay-updates --safe-links --progress \
  "$VAULT/5.0/" "$BASE/5.0/" >> "$LOG" 2>&1

rsync -rtlH --delete-after --delay-updates --safe-links --progress \
  "$VAULT/6.10/" "$BASE/6.10/" >> "$LOG" 2>&1

rsync -rtlH --delete-after --delay-updates --safe-links --progress \
  "$VAULT/7.0.1406/" "$BASE/7.0.1406/" >> "$LOG" 2>&1

echo "[$(date)] sync.sh finished" >> "$LOG"
