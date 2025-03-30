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

# Set the GitHub token if available from environment
GITHUB_TOKEN=${GITHUB_TOKEN:-}
AUTH_HEADER=""
if [ -n "$GITHUB_TOKEN" ]; then
    AUTH_HEADER="-H 'Authorization: token $GITHUB_TOKEN'"
fi

# Fetch all repository names for HorseIncorporated from GitHub
REPOS=$(curl -s $AUTH_HEADER https://api.github.com/orgs/HorseIncorporated/repos | jq -r '.[].name')

# Clone each repo, except for "workspace"
for REPO in $REPOS
do
  if [ "$REPO" != "workspace" ]
  then
    # Use HTTPS instead of SSH for cloning
    echo "Cloning $REPO..."
    git clone "https://github.com/HorseIncorporated/${REPO}.git" || echo "Failed to clone $REPO"
  fi
done

# Return to the workspace directory
cd ..
