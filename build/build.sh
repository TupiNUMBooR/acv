#!/usr/bin/env bash
set -euo pipefail

docker-compose build
docker-compose push
