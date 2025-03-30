#!/usr/bin/env bash

set -e

echo "Starting setup process..."

# Clone all the repos in the github organization: HorseIncorporated
echo "Step 1: Cloning repositories..."
./sync/clone.sh

# Directory where repos are cloned
REPOS_DIR="repos"

# Check if repos directory exists
if [ ! -d "$REPOS_DIR" ]; then
  echo "Error: $REPOS_DIR directory not found. Clone operation may have failed."
  exit 1
fi

# Check if any repos were cloned
if [ -z "$(ls -A $REPOS_DIR 2>/dev/null)" ]; then
  echo "Warning: No repositories were cloned. Continuing setup..."
fi

# Create the .devcontainer directory
echo "Creating .devcontainer directory..."
mkdir -p "config/.devcontainer"

# Create a simple devcontainer.json file
cat > "config/.devcontainer/devcontainer.json" << EOF
{
  "name": "Default Dev Container",
  "image": "mcr.microsoft.com/devcontainers/universal:latest",
  "features": {}
}
EOF

echo "Step 2: Setting up .devcontainer in each repository..."
# Loop through all directories in the repos directory
for repo in "$REPOS_DIR"/*; do
  if [ -d "$repo" ]; then
    echo "Processing repository: $(basename "$repo")"
    
    # Change to repository directory
    cd "$repo"
    
    # Try to pull latest changes
    echo "Pulling latest changes for $(basename "$repo")..."
    git pull origin main || git pull origin master || echo "Failed to pull updates for $(basename "$repo")"
    
    # Check and remove .devcontainer if it exists
    if [ -d ".devcontainer" ]; then
      echo "Found .devcontainer in $(basename "$repo"), removing..."
      rm -rf ".devcontainer"
    fi
    
    # Copy .devcontainer from config directory
    echo "Copying .devcontainer to $(basename "$repo")..."
    cp -r "/workspace/config/.devcontainer" "./" || {
      echo "Failed to copy .devcontainer directory. Creating a basic one..."
      mkdir -p .devcontainer
      cat > .devcontainer/devcontainer.json << EOF
{
  "name": "Default Dev Container",
  "image": "mcr.microsoft.com/devcontainers/universal:latest",
  "features": {}
}
EOF
    }
    
    # Return to workspace directory
    cd "$(dirname "$(dirname "$repo")")"
  fi
done

echo "Setup completed successfully!"
