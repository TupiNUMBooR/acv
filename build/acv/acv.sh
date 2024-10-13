#!/usr/bin/env bash
set -euo pipefail

trap "exit" TERM

log() {
  echo "[$(date -u "+%F %T Z")] $1"
}

find_smallest_file() {
  cd files/1_todo
  find . -type f -exec du -b {} + | sort -n | head -n 1 | cut -f2 | cut -d'/' -f2- | sed 's/\//\t/'
  cd ../..
}

init() {
  cycle_skipped=0
  mkdir -p "files/1_todo"
  if [ -d scripts ] && [ -z "$(ls -A scripts)" ]; then
    cp -r scripts-install/. scripts/
  fi

  for f in "scripts"/*.sh; do
    dir_name=$(basename "$f" .sh)
    mkdir -p "files/1_todo/$dir_name"
  done
}

run() {
  init
  while true; do
    file=$(find_smallest_file)
    if test -z "$file"; then
      if (( cycle_skipped++ % 600 == 0 )); then
        log "no file to process; $cycle_skipped skipped"
      fi
      sleep 1
    elif [[ "$file" == *.part ]]; then
      echo "found file with .part: $file; sleeping for 15 sec before start;"
      sleep 15
    else
      type=$(echo "$file" | cut -f1)
      file=$(echo "$file" | cut -f2)
      log "==== ==== ==== ====  ==== ===="
      log "starting $type.sh $file"
      mkdir -p "$(dirname "files/4_processed/$type/$file")"
      if "scripts/$type.sh" "files/1_todo/$type/$file" "files/4_processed/$type/$file"; then
        log "finished $type.sh $file"
        mkdir -p "$(dirname "files/2_done/$type/$file")"
        mv "files/1_todo/$type/$file" "files/2_done/$type/$file"
      else
        log "failed $type.sh $file"
        mkdir -p "$(dirname "files/3_failed/$type/$file")"
        mv "files/1_todo/$type/$file" "files/3_failed/$type/$file"
      fi
      sleep 0.1
    fi
  done
}

run
