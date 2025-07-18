#!/bin/bash
set -e
echo "[$(date)] Sync start ${MIRROR_NAME}" >> /var/log/sync.log
mkdir -p "$MIRROR_DIR"
rsync -rtlH --delete-after --delay-updates --safe-links --progress \
      "$UPSTREAM" "$MIRROR_DIR" >> /var/log/sync.log 2>&1
echo "[$(date)] Sync end   ${MIRROR_NAME}"   >> /var/log/sync.log
