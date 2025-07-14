#!/bin/bash
set -e

# Stop and remove all containers
for container in $(docker ps -aq); do
    docker rm -f "$container"
done

# Rebuild and recreate containers
docker compose build
docker compose up -d --force-recreate
