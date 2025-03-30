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

### run setup to clone all repositories that belong to the organization

```shell
./setup.sh
```

### Automate CI and infra workflows

github.event.inputs.codespace
github.event.inputs.command

```yml
gh codespace exec "${{ github.event.inputs.codespace }}" -- ${{ github.event.inputs.command }}
```

## claude code

from claude code docs:

> Use --print (-p) to run Claude in non-interactive mode. In this mode, you can set the ANTHROPIC_API_KEY environment variable to provide a custom API key.

```shell
export ANTHROPIC_API_KEY=sk_...
claude -p "update the README with the latest changes" --allowedTools "Bash(git diff:*)" "Bash(git log:*)" Edit
```

In our case, we're using config/.devcontainer/devcontainer.env for this purpose. For now, this is how we'll push config vars to each repositories' coding agent in CI.
