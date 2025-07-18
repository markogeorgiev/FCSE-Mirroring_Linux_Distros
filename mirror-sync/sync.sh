#!/bin/bash
set -e

echo "[$(date)] sync.sh started for $MIRROR_NAME" >> /var/log/sync.log

# Base CentOS vault URL
CENTOS_BASE="rsync://archive.kernel.org/centos-vault"

if [[ "$MIRROR_NAME" == "centos" ]]; then
  mkdir -p "$MIRROR_DIR/5.11"
  mkdir -p "$MIRROR_DIR/6.10"
  mkdir -p "$MIRROR_DIR/7"

  echo "Syncing CentOS 5.11..." >> /var/log/sync.log
  rsync -avz --delete "$CENTOS_BASE/5.11/" "$MIRROR_DIR/5.11/" >> /var/log/sync.log 2>&1

  echo "Syncing CentOS 6.10..." >> /var/log/sync.log
  rsync -avz --delete "$CENTOS_BASE/6.10/" "$MIRROR_DIR/6.10/" >> /var/log/sync.log 2>&1

  echo "Syncing CentOS 7.0.1406 → 7/ ..." >> /var/log/sync.log
  rsync -avz --delete "$CENTOS_BASE/7.0.1406/" "$MIRROR_DIR/7/" >> /var/log/sync.log 2>&1

  echo "[$(date)] sync.sh finished for centos" >> /var/log/sync.log

  exit 0
fi

# Default behavior for other mirrors
mkdir -p "$MIRROR_DIR"
rsync -rtlH --delete-after --delay-updates --safe-links --progress \
      "$UPSTREAM" "$MIRROR_DIR" >> /var/log/sync.log 2>&1

echo "[$(date)] sync.sh finished for $MIRROR_NAME" >> /var/log/sync.log
