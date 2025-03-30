# workspace

## helpful links

[View Documentation](https://publish.obsidian.md/horseincorporated/workspace)

## installation

### CLAUDE_CODE_GH org secret

create and set your CLAUDE_CODE_GH fine-grained access token manually

create a fine-grained access token in github

### ANTHROPIC_API_KEY org secret

create a new personal api token with claude

### Setup your Codespace

1. navigate to the [HorseIncorporated/workspace](https://github.com/HorseIncorporated/workspace) repository.
2.

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
