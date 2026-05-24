# humanlayer-scripts

Fork of [humanlayer/humanlayer](https://github.com/humanlayer/humanlayer) AI scripts.

## Onboarding (fresh Fedora Silverblue install)

```sh
# 1. Install requirements
sudo dnf install -y podman podman-compose just

# 2. Clone and enter
git clone https://github.com/happytomatoe/humanlayer-scripts.git
cd humanlayer-scripts

# 3. Install SearXNG (required for web search via MCP)
./docker/searxng/install.sh

# 4. Install opencode config
just install      # syncs .opencode/ to ~/.config/opencode/
just sync-config  # copies opencode.json (MCP config)
just sync-agent   # copies AGENT.md to AGENTS.md
```

All done. SearXNG starts automatically on boot via systemd user services.

### SearXNG management

```sh
just searxng-status   # check if running
just searxng-logs     # tail logs
just searxng-up       # start
just searxng-down     # stop
just searxng-key      # generate new secret key
```

> **Note:** `SEARXNG_SECRET_KEY` can be set in your environment. If unset, it defaults to `changeme`. Generate a strong key with `just searxng-key`.
