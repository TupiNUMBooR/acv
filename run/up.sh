#!/usr/bin/env bash
set -euo pipefail

mkdir -p files scripts
docker-compose pull
docker-compose up -d --force-recreate
docker-compose logs -f
