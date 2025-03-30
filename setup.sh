#!/usr/bin/env bash

# clone all the repos in the github organization: HorseIncorporated
./sync/clone.sh

# for each repo, check if .devcontainer exists in the root directory of that repo. if it does, delete it.
# Directory where repos are cloned
REPOS_DIR="repos"

# Loop through all directories in the repos directory
# remove any current .devcontainer and replace it with the one in this directory.
for repo in "$REPOS_DIR"/*; do
  if [ -d "$repo" ]; then
    if [ -d "$repo/.devcontainer" ]; then
      echo "Found .devcontainer in $repo, removing..."
      rm -rf "$repo/.devcontainer"
      echo "Copying .devcontainer from config directory to $repo..."
      cp -r "$(dirname "$0")/config/.devcontainer" "$repo/"
    fi
  fi
done
