#!/bin/sh
set -e

# per-mirror log file in the shared /var/log directory
log_file="/var/log/${MIRROR_NAME}-sync.log"

# ensure the log directory and file exist
mkdir -p "$(dirname "$log_file")"
touch    "$log_file"

echo "[$(date)] Syncing $MIRROR_NAME from $UPSTREAM" >> "$log_file"

if [ -n "$DISTRO_FILTER" ]; then
  rsync -aH --delete \
    --include="$DISTRO_FILTER/" \
    --include="$DISTRO_FILTER/**" \
    --exclude='*' \
    "$UPSTREAM" "$MIRROR_DIR" >> "$log_file" 2>&1
else
  rsync -aH --delete "$UPSTREAM" "$MIRROR_DIR" >> "$log_file" 2>&1
fi

chown -R www-data:www-data "$MIRROR_DIR"

echo "[$(date)] Completed $MIRROR_NAME" >> "$log_file"
