# workspace

[View Documentation](https://publish.obsidian.md/horseincorporated/workspace)

## run workspace

```shell
./setup.sh
```

## claude code



### Automate CI and infra workflows

from claude code docs:

> Use --print (-p) to run Claude in non-interactive mode. In this mode, you can set the ANTHROPIC_API_KEY environment variable to provide a custom API key.

```shell
export ANTHROPIC_API_KEY=sk_...
claude -p "update the README with the latest changes" --allowedTools "Bash(git diff:*)" "Bash(git log:*)" Edit
```

In our case, we're using config/.devcontainer/devcontainer.env for this purpose. For now, this is how we'll push config vars to each repositories' coding agent in CI.

###

```yml
name: Run Command in Codespace

on:
  workflow_dispatch:
    inputs:
      codespace:
        description: "The Codespace name or ID to operate on."
        required: true
      command:
        description: "The terminal command to execute inside the Codespace."
        required: true

jobs:
  run-command:
    runs-on: ubuntu-latest
    steps:
      - name: Install GitHub CLI if needed
        run: |
          if ! command -v gh >/dev/null; then
            sudo apt-get update && sudo apt-get install -y gh
          fi
      - name: Authenticate GitHub CLI
        run: echo "${{ secrets.GITHUB_TOKEN }}" | gh auth login --with-token > /dev/null
      - name: Unpause Codespace
        run: gh codespace resume "${{ github.event.inputs.codespace }}" > /dev/null
      - name: Execute Terminal Command
        run: gh codespace exec "${{ github.event.inputs.codespace }}" -- ${{ github.event.inputs.command }} > /dev/null
      - name: Pause Codespace
        run: gh codespace stop "${{ github.event.inputs.codespace }}" > /dev/null
```


gh codespace exec "${{ github.event.inputs.codespace }}" -- ${{ github.event.inputs.command }}
