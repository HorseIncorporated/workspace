#!/usr/bin/env bash
for dir in */; do
  directory_name=${dir%/}
  cat "$directory_name/README.md" >> "$directory_name/home.md"
  rm "$directory_name/README.md"
  echo "performed this action related to: $directory_name"
done
