#!/bin/bash

source ./config/rules.conf || {
  echo "Error: rules.conf not found!"
  exit 1
}

inotifywait -m -e close_write,moved_to --format '%w' \
  --exclude '.*\.tmp$|cyber-cleand\.sh' "${WATCH_DIRS[@]}" | while read -r NEW_FILE; do

  echo "Detected change: $NEW_FILE"
  ./cyber-cleand.sh "$NEW_FILE" prod

done
