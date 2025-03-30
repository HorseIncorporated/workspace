#!/usr/bin/env bash

# @todo fix the script to do this directory switching better
# Start in directory: ./workspace/
cd ..
# Echo the current directory to help with debugging
echo "Current working directory: $(pwd)"

# Create the 'repos' directory if it doesn't exist
mkdir -p repos

# Change into the repos directory where we'll clone everything
cd repos
# Fetch all repository names for HorseIncorporated from GitHub
REPOS=$(curl -s https://api.github.com/orgs/HorseIncorporated/repos | jq -r '.[].name')

# Clone each repo, except for "workspace"
for REPO in $REPOS
do
  if [ "$REPO" != "workspace" ]
  then
    git clone "git@github.com:HorseIncorporated/${REPO}.git"
  fi
done
