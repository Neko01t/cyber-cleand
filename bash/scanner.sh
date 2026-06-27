#!/bin/bash

WATCH_DIR="/home/oms/Downloads"
inotifywait -m -e close_write,moved_to --format '%w%f' "$WATCH_DIR" | while read -r NEW_FILE; do
  echo "Detected new file $NEW_FILE"

done
