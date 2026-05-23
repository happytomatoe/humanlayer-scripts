oc-home := env_var("HOME") + "/.config/opencode"
oc-project := ".opencode"

# ── Setup ───────────────────────────────────────────────

# Symlink project .opencode/ to ~/.config/opencode/ (canonical location)
link:
  mkdir -p {{oc-home}}
  ln -sfn $(pwd)/{{oc-project}}/command {{oc-home}}/command
  ln -sfn $(pwd)/{{oc-project}}/agent {{oc-home}}/agent
  ln -sfn $(pwd)/{{oc-project}}/skills {{oc-home}}/skills
  cp -n opencode.json {{oc-home}}/opencode.json 2>/dev/null || echo "opencode.json already exists at {{oc-home}}/opencode.json (use `just sync-config` to overwrite)"
  @echo "Linked .opencode/{command,agent,skills} -> {{oc-home}}/"

# Copy project .opencode/ to ~/.config/opencode/ (canonical location)
sync:
  mkdir -p {{oc-home}}
  cp -r {{oc-project}}/command {{oc-home}}/command
  cp -r {{oc-project}}/agent {{oc-home}}/agent
  cp -r {{oc-project}}/skills {{oc-home}}/skills
  @echo "Synced .opencode/{command,agent,skills} -> {{oc-home}}/"

# Copy opencode.json (MCP config) to ~/.config/opencode/
sync-config:
  cp opencode.json {{oc-home}}/opencode.json
  @echo "Synced opencode.json -> {{oc-home}}/opencode.json"

# Full install: sync everything to global config
install: sync sync-config
  @echo "OpenCode config installed at {{oc-home}}/"

# ── Agents ──────────────────────────────────────────────

# Copy AGENT.md to OpenCode (AGENTS.md) and Hermes (SOUL.md)
sync-agent:
  #!/usr/bin/env bash
  cp AGENT.md "{{oc-home}}/AGENTS.md"
  echo "Copied AGENT.md -> {{oc-home}}/AGENTS.md"
  soul=$(<~/.hermes/SOUL.md); agent=$(<AGENT.md)
  if [[ "$soul" == *"$agent"* ]]; then
    echo "Hermes SOUL.md: already has agent guidelines, skipped"
  else
    { echo ""; echo "---"; echo ""; cat AGENT.md; } >> ~/.hermes/SOUL.md
    echo "Hermes SOUL.md: appended AGENT.md"
  fi

# ── Lists ───────────────────────────────────────────────

# List all opencode skills
list-skills:
  @find .opencode/skills -name SKILL.md | sed 's|.opencode/skills/\(.*\)/SKILL.md|  - \1|'

# List all opencode commands
list-commands:
  @ls .opencode/command/*.md | sed 's|.opencode/command/\(.*\)\.md|  - \1|'

# List MCP servers in opencode.json
list-mcp:
  @rg '"type"' opencode.json || echo "no MCP servers configured"

# ── SearXNG (Quadlet — systemd-managed containers) ─────

# Install/update SearXNG quadlet files and enable services
searxng-install:
  ./docker/searxng/install.sh

# Start SearXNG (via systemd user service)
searxng-up:
  systemctl --user start searxng.service

# Stop SearXNG
searxng-down:
  systemctl --user stop searxng.service

# View SearXNG logs
searxng-logs:
  journalctl --user -u searxng.service -f

# Check SearXNG service status
searxng-status:
  @systemctl --user status searxng.service --no-pager; true
  @echo "---"
  @curl -s -o /dev/null -w "Port 8080 reachable: %{http_code}\n" http://localhost:8080 || echo "Port 8080 reachable: 000"

# Generate a random secret key for SearXNG
searxng-key:
  @openssl rand -hex 32

# ── Help ────────────────────────────────────────────────

default:
  @just --list
