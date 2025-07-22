#!/bin/sh

set -e

log_file="/var/log/mirror-sync.log"
echo "[$(date)] Syncing $MIRROR_NAME from $UPSTREAM" >> "$log_file"

if [ -n "$DISTRO_FILTER" ]; then
  rsync -aH --delete \
    --include="$DISTRO_FILTER/" \
    --include="$DISTRO_FILTER/**" \
    --exclude='*' \
    "$UPSTREAM" "$MIRROR_DIR"
else
  rsync -aH --delete "$UPSTREAM" "$MIRROR_DIR"
fi

echo "[$(date)] Completed $MIRROR_NAME" >> "$log_file"