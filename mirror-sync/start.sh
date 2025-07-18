#!/bin/bash

# Run initial sync before starting services
/usr/local/bin/sync.sh

# Start cron for periodic sync
service cron start

# Start nginx
nginx -g 'daemon off;'
