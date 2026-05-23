#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
QUADLET_DIR="${HOME}/.config/containers/systemd"

echo "==> Installing SearXNG quadlet files to ${QUADLET_DIR}"
mkdir -p "${QUADLET_DIR}"

for src in "${REPO_DIR}/docker/searxng/quadlet"/*; do
  dest="${QUADLET_DIR}/$(basename "$src")"
  sed "s|REPO_DIR|${REPO_DIR}|g" "$src" > "$dest"
  echo "  $(basename "$src")"
done

echo "==> Enabling lingering for user services (starts on boot)"
loginctl enable-linger 2>/dev/null || true

echo "==> Reloading systemd user daemon"
systemctl --user daemon-reload

echo "==> Enabling services (will start on boot)"
systemctl --user enable searxng-network.service valkey.service searxng.service

echo ""
echo "==> Starting services now (image pull may take a minute)..."
for svc in searxng-network.service valkey.service searxng.service; do
  echo "  Starting $svc..."
  systemctl --user start "$svc" &
done
wait

echo ""
echo "==> Status:"
for svc in searxng-network.service valkey.service searxng.service; do
  echo "  $svc $(systemctl --user is-active "$svc")"
done

echo ""
echo "==> Done! SearXNG will start on boot."
echo "    Check status: systemctl --user status searxng.service"
echo "    View logs:    journalctl --user -u searxng.service -f"
