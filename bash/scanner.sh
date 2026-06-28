#!/bin/bash

WATCH_DIRS=(
  "/home/oms/Documents/dele/cyber-cleand/bash/"
  "/home/oms/Documents/dele/cyber-cleand/rust/"
)

inotifywait -m -e close_write,moved_to --format '%w%f' \
  --exclude '.*\.tmp$|cyber-cleand\.sh' "${WATCH_DIRS[@]}" | while read -r NEW_FILE; do

  echo "Detected change: $NEW_FILE"
  ./cyber-cleand.sh . prod

done
