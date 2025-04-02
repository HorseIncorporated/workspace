# coder devcontainer

## migrate into an existing project

### installation / setup

- Add the feature configuration to your existing `.devcontainer/devcontainer.json file

```json
{
  "image": "mcr.microsoft.com/devcontainers/python:3.11-bullseye",
  "features": {
    "ghcr.io/HorseIncorporated/features/coder:1": {
       "OPENAI_API_KEY": "${{ env.OPENAI_API_KEY }}",
       "ANTHROPIC_API_KEY": "${{ env.ANTHROPIC_API_KEY }}",
       "FIREWALL_ENABLED" "${{ env.FIREWALL_ENABLED }}"
    }
  }
}
```

### usage guide

```bash

# 1. Create/Start the container
devcontainer up --workspace-folder .

# 2. Run Claude Code commands inside your container
devcontainer exec --workspace-folder . "claude -p \"add a duck and your github username to README.md. commit to a new branch and create a pull request to main.\" --dangerously-skip-permissions"
```

Notes:
	•	Firewalling is required if you are executing a Claude Code prompt without human approval (--dangerously-skip-permissions flag).
