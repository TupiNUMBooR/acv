#!/usr/bin/env bash
set -euo pipefail

docker-compose -f ../build/docker-compose.yml build

mkdir -p ../run/files/1_todo/test ../run/scripts
cp -a test ../run/files/1_todo
docker-compose -f ../run/docker-compose.yml run --rm -it acv || :

echo test finish
rm -rf ../run/files ../run/scripts
