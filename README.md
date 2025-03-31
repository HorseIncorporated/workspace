# workspace

## helpful links

[View Documentation](https://publish.obsidian.md/horseincorporated/workspace)

## installation

### ANTHROPIC_API_KEY

1. navigate to [Anthropic Console API Keys](https://console.anthropic.com/settings/keys) and create a new API key

2. (local development only, skip if developing via codespaces) in your terminal, add your GH_PAT and auth with gh cli

```shell
unset ANTHROPIC_API_KEY
export ANTHROPIC_API_KEY=<your-anthropic-api-key>
```

3. navigate to [org secrets](https://github.com/organizations/HorseIncorporated/settings/secrets/actions) and set your `ANTHROPIC_API_KEY` secret

### GH_PAT

1. navigate to [GitHub Personal Access Tokens](https://github.com/settings/personal-access-tokens) and create a new Fine Grained personal access token.

Ensure:

- The resource owner is `HorseIncorporated`
- Your PAT has enough permission to create codespaces, as well as any other scopes needed.

Copy the generaterd PAT to clipboard.

2. (local development only, skip if developing via codespaces) in terminal, add your GH_PAT and auth with gh cli

```shell
unset GITHUB_TOKEN
export GH_PAT=<your-pat-token-copied-to-clipboard>
echo $GH_PAT | gh auth login -p https --with-token > /dev/null
```

3. navigate to [org secrets](https://github.com/organizations/HorseIncorporated/settings/secrets/actions) and set your `GH_PAT` secret.

### Clone this Repository via HTTPS

```shell
git clone https://github.com/HorseIncorporated/workspace.git
cd workspace
```

### Create your codespace

```shell
gh codespace create -r HorseIncorporated/workspace

###
# Grab the codespace ID
###
export CODESPACE_ID=<your-codespace-id-here>
```

### Run Claude Code manually (must be ran once)

After Codespace is built and becomes available (takes between 5-10 minutes), navigate to: [View Codespaces](https://github.com/HorseIncorporated/workspace/codespaces)

Click "..." -> "Open in Browser"


![alt text](<Arc _2025-03-30 at 23.10.25@2x.png>)


Once loaded, open up terminal (cmd/ctrl+t by default) and enter the following command

```shell
claude --dangerously-skip-permissions
```

Go through the setup steps and click Yes to any prompts.

### Stop the container

Navigate to [View Codespaces](https://github.com/HorseIncorporated/workspace/codespaces)

Click "..." -> "Stop container".

## Verify installation

```shell
gh workflow run "coder" \
  --repo HorseIncorporated/workspace \
  --field codespace=$CODESPACE_ID \
  --field prompt="Add a duck to workspace/README.md and create a pull request. Add a duck to repos/docs/README.md and create a pull request"
```
