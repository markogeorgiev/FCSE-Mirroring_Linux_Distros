#!/bin/bash
set -e

echo "[$(date)] sync.sh started for $MIRROR_NAME" >> /var/log/mirror-sync.log

# CentOS vault mirror
CENTOS_BASE="rsync://archive.kernel.org/centos-vault"
# Rocky Linux vault mirror
ROCKY_BASE="rsync://mirror1.hs-esslingen.de/rocky"

if [[ "$MIRROR_NAME" == "centos" ]]; then
  mkdir -p "$MIRROR_DIR/5.11" "$MIRROR_DIR/6.10" "$MIRROR_DIR/7"

  echo "Syncing CentOS 5.11..." >> /var/log/mirror-sync.log
  rsync -avz --delete "$CENTOS_BASE/5.11/" "$MIRROR_DIR/5.11/" >> /var/log/mirror-sync.log 2>&1

  echo "Syncing CentOS 6.10..." >> /var/log/mirror-sync.log
  rsync -avz --delete "$CENTOS_BASE/6.10/" "$MIRROR_DIR/6.10/" >> /var/log/mirror-sync.log 2>&1

  echo "Syncing CentOS 7.0.1406 → 7/ ..." >> /var/log/mirror-sync.log
  rsync -avz --delete "$CENTOS_BASE/7.0.1406/" "$MIRROR_DIR/7/" >> /var/log/mirror-sync.log 2>&1

  echo "[$(date)] sync.sh finished for centos" >> /var/log/mirror-sync.log
  exit 0
fi

if [[ "$MIRROR_NAME" == "rocky" ]]; then
  mkdir -p "$MIRROR_DIR/8.10" "$MIRROR_DIR/9.6" "$MIRROR_DIR/10.0"

  echo "Syncing Rocky Linux 8.10..." >> /var/log/mirror-sync.log
  rsync -avz --delete "$ROCKY_BASE/8.10/" "$MIRROR_DIR/8.10/" >> /var/log/mirror-sync.log 2>&1

  echo "Syncing Rocky Linux 9.6..." >> /var/log/mirror-sync.log
  rsync -avz --delete "$ROCKY_BASE/9.6/" "$MIRROR_DIR/9.6/" >> /var/log/mirror-sync.log 2>&1

  echo "Syncing Rocky Linux 10.0..." >> /var/log/mirror-sync.log
  rsync -avz --delete "$ROCKY_BASE/10.0/" "$MIRROR_DIR/10.0/" >> /var/log/mirror-sync.log 2>&1

  echo "[$(date)] sync.sh finished for rocky" >> /var/log/mirror-sync.log
  exit 0
fi

# Default fallback
mkdir -p "$MIRROR_DIR"
rsync -rtlH --delete-after --delay-updates --safe-links --progress \
      "$UPSTREAM" "$MIRROR_DIR" >> /var/log/mirror-sync.log 2>&1

echo "[$(date)] sync.sh finished for $MIRROR_NAME" >> /var/log/mirror-sync.log
