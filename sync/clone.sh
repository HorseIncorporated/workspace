#!/usr/bin/env bash

# @todo fix the script to do this directory switching better
# Start in directory: ./workspace/
cd ..

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
