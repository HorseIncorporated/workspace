#!/usr/bin/env bash
set -e

echo "Installing Aider"

# 1. Ensure Python3 and pip are present (if base image lacked Python)
if ! command -v python3 &> /dev/null; then
    echo "Python not found. Installing Python3 and pip..."
    apt-get update && apt-get install -y python3 python3-pip >/dev/null
fi

# 2. Install Aider via pip (using aider-install for isolated setup)
python3 -m pip install --no-cache-dir --upgrade pip >/dev/null
python3 -m pip install --no-cache-dir aider-install >/dev/null
aider-install

# 3. If API keys were provided, configure them as environment variables
if [ -n "$OPENAI_API_KEY" ]; then
    echo "export OPENAI_API_KEY='$OPENAI_API_KEY'" >> /etc/profile.d/aider.sh
fi
if [ -n "$ANTHROPIC_API_KEY" ]; then
    echo "export ANTHROPIC_API_KEY='$ANTHROPIC_API_KEY'" >> /etc/profile.d/aider.sh
fi

# 4. (Optional) Mark repo as safe for git if using Aider inside container
git config --global --add safe.directory /workspaces/$WORKSPACE || true

echo "Installing firewall dependencies (iptables, ipset, dnsutils, jq, netmask)"
apt-get update && apt-get install -y iptables ipset dnsutils jq netmask >/dev/null

# Copy init-firewall.sh to /usr/local/bin and set permissions
echo "Copying init-firewall.sh to /usr/local/bin"
cp init-firewall.sh /usr/local/bin/init-firewall.sh
chmod +x /usr/local/bin/init-firewall.sh

# Grant non-root user passwordless sudo to run it
if [ "${_REMOTE_USER}" != "root" ]; then
    echo "${_REMOTE_USER} ALL=(root) NOPASSWD: /usr/local/bin/init-firewall.sh" > /etc/sudoers.d/init-firewall
    chmod 0440 /etc/sudoers.d/init-firewall
fi

# Conditionally run it at build time if desired
if [ "${FIREWALL_ENABLED}" = "true" ]; then
    echo "FIREWALL_ENABLED is true, running init-firewall.sh now..."
    /usr/local/bin/init-firewall.sh
fi

# Install Claude CLI
echo "Installing Claude CLI via npm"
npm install -g @anthropic-ai/claude-code
