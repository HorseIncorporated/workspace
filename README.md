# workspace

## helpful links

[View Documentation](https://publish.obsidian.md/horseincorporated/workspace)

## installation

```shell

# https://console.anthropic.com/settings/keys
export ANTHROPIC_API_KEY=<your-anthropic-api-key>

# create a new fine-grained personal access token: https://github.com/settings/personal-access-tokens
# Resource owner: `HorseIncorporated`
# Your PAT needs permission to create codespaces, as well as any other scopes needed.
unset GITHUB_TOKEN
export GH_PAT=<your-pat-token-copied-to-clipboard>
echo $GH_PAT | gh auth login -p https --with-token > /dev/null

# clone this repository to your local machine using HTTPS
git clone https://github.com/HorseIncorporated/workspace.git && cd workspace

# create your codespace
gh codespace create -R HorseIncorporated/workspace --devcontainer-path=.devcontainer/devcontainer.json -s

# create new GitHub action variable as well: https://github.com/HorseIncorporated/workspace/settings/variables/actions
export CODESPACE_ID=<your-new-codespace-id>

# Once started, ssh in in order to setup Claude Code
gh cs ssh # when prompted, select your Available codespace

# Run claude config once so we can skip permissions
claude --dangerously-skip-permissions

# after claude configuration is complete, type the following commands
"/exit" # to get out of the claude code REPL environment
"exit" # to get out of the ssh environment

# stop the container, it's fully configured and ready for github actions usage
gh cs stop -c $CODESPACE_ID

# gh cs delete -c $CODESPACE_ID ## if for whatever reason you want to kill & delete the container outright

# verify everything worked appropriately
gh workflow run "coder" \
  --repo HorseIncorporated/workspace \
  --field prompt="Add a duck to the workspace README and create a new PR to main with your github username."
```
