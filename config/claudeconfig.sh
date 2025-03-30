# Non-interactive mode is especially useful when you pre-configure the set of commands Claude is allowed to use:
export ANTHROPIC_API_KEY=sk_...
claude -p "update the README with the latest changes" --allowedTools "Bash(git diff:*)" "Bash(git log:*)" Edit


# Let npm test to run without approval
claude config add allowedTools "Bash(npm test)"

# Let npm test and any of its sub-commands to run without approval
claude config add allowedTools "Bash(npm test:*)"

# Instruct Claude to ignore node_modules
claude config add ignorePatterns node_modules
claude config add ignorePatterns "node_modules/**"
