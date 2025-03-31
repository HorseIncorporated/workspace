#!/usr/bin/env bash

# @todo fix the script to do this directory switching better
# Start in directory: ./workspace/

# Echo the current directory to help with debugging
echo "Current working directory: $(pwd)"

# Create the 'repos' directory if it doesn't exist
mkdir -p repos

# Change into the repos directory where we'll clone everything
cd repos

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Attempting to install..."
    apt-get update && apt-get install -y jq || { echo "Failed to install jq. Please install it manually."; exit 1; }
fi

cd repos
REPOS=$(curl -s -H "Authorization: token ${GH_PAT}" https://api.github.com/orgs/HorseIncorporated/repos | jq -r '.[].name')
for REPO in $REPOS
do
  if [ "$REPO" != "workspace" ]
  then
    # Use HTTPS instead of SSH for cloning
    echo "Cloning $REPO..."
    git clone "https://github.com/HorseIncorporated/${REPO}.git" || echo "Failed to clone $REPO"
  fi
done
cd ..
