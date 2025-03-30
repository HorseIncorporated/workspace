# workspace

## helpful links

[View Documentation](https://publish.obsidian.md/horseincorporated/workspace)

## installation

### github org secrets

#### ANTHROPIC_API_KEY

1. navigate to [Anthropic Console API Keys](https://console.anthropic.com/settings/keys) and create a new API key

2. navigate to [GitHub org secrets](https://github.com/organizations/HorseIncorporated/settings/secrets/actions) and set your `ANTHROPIC_API_KEY` secret

![alt text](<Arc _2025-03-30 at 03.16.19.png>)

#### CLAUDE_CODE_GH

1. navigate to [Anthropic Console API Keys](https://console.anthropic.com/settings/keys) and create a new API key.

2. navigate to [GitHub org secrets](https://github.com/organizations/HorseIncorporated/settings/secrets/actions) and set your `CLAUDE_CODE_GH` secret -- this grants access to actions to act on your behalf.

### Setup your Codespace

1. navigate to the [HorseIncorporated/workspace](https://github.com/HorseIncorporated/workspace) repository.
2. click on the green `<> Code` button. ![alt text](<Arc _2025-03-30 at 03.06.56@2x.png>)
3. click on the green `Create codespace on main` button. ![alt text](<Arc _2025-03-30 at 03.07.38@2x.png>)

## on startup of codespace

### clone all repos

```shell
./setup.sh
```

###

```shell
# to find your github codespace id
gh codespace list

# set it locally so you can reuse the same devcontainer in perpituity
export CODESPACE_ID=<your-codespace-id-here>

# run a command on the codespace that verifies that claude runs properly
# and is able to serve responses even with
# the --dangerously-skip-permissions flag enabled
gh workflow run "Run Command in Codespace" \
  --repo YourUsername/HorseInc \
  --field codespace=$CODESPACE_ID \
  --field command="claude -p \"why is the sky blue?\" --dangerously-skip-permissions"
```
