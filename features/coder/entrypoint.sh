#!/usr/bin/env bash
if [ "${FIREWALL_ENABLED}" = "true" ]; then
    echo "[entrypoint.sh] Enabling firewall..."
    sudo /usr/local/bin/init-firewall.sh
fi
exec "$@"

cp entrypoint.sh /usr/local/bin/coder-entrypoint.sh
chmod +x /usr/local/bin/coder-entrypoint.sh
