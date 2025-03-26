#!/usr/bin/env bash

cd ../..

for folder in */; do
  # Remove the trailing slash
  folder="${folder%/}"

  # Skip the folders "api", "docs", and "db"
  if [ "$folder" != "api" ] && [ "$folder" != "docs" ] && [ "$folder" != "prompts" ]&& [ "$folder" != "db" ]; then
    cat > "$folder/README.md" <<EOF
# $folder

[View Documentation](https://publish.obsidian.md/horseincorporated/$folder)
EOF
  fi
done


for folder in */; do
  folder="${folder%/}"

  # Skip the same set of folders
  if [ "$folder" != "api" ] && [ "$folder" != "docs" ] && [ "$folder" != "db" ] && [ "$folder" != "prompts" ]; then
    # Change into the folder
    cd "$folder" || exit 1

    # If there's no .git directory yet, initialize and create main branch
    if [ ! -d .git ]; then
      git init
      git checkout -b main
    fi

    # Stage and commit the README.md (and any other files)
    git add .
    git commit -m "initial commit" || true

    # Create the repo in the HorseIncorporated organization
    # --public can be changed to --private if desired
    gh repo create "HorseIncorporated/$folder" \
      --public \
      --source=. \
      --remote=origin \
      --push \
      -y

    cd ..
  fi
done
