# mirror-docker-v2

This repository is a modernized, more flexible version of [LunaStev's mirror-docker](https://github.com/LunaStev/mirror-docker). It provides a lightweight, Docker-based solution for setting up customizable Linux distribution mirrors.

## Overview

Each mirror runs in its own Docker container, one per version of the distro you want to mirror. The setup is based on a generic `Dockerfile` and a shared sync script located in the `mirror-sync/` directory. Configuration is handled via environment variables defined in `docker-compose.yml`.

## Adding a New Distro Version

To mirror a new distribution or version:

1. Use `rsync --list-only [URL]` to explore available versions and select the one you want to mirror.
2. Copy an existing service definition in `docker-compose.yml` and update the following environment variables:

   * `MIRROR_NAME`: a short name for this mirror
   * `MIRROR_DIR`: target directory inside the container (e.g. `/var/www/html/ubuntu/` if your distro is Ubuntu)
   * `UPSTREAM`: the full rsync URL of the upstream mirror
   * `DISTRO_FILTER`: choose which specific version you want to mirror (e.g. choose `jammy` for Ubuntu 22.04 or `10.0` for Rocky 10.0)
3. Configure the `volumes:` section so that the local path reflects the mirror hierarchy.
   Example: for Ubuntu 22.04, use

   ```yaml
   - /mirrordata/ubuntu:/var/www/html
   ```

   This ensures the mirrored files for all Ubuntu versions live under `/mirrordata/ubuntu/`.
4. (Optional) If you don’t need logging inside the container, you can remove the log volume mount from both the `docker-compose.yml` service and from `sync.sh`.