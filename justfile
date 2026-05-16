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

# ── Docker: SearXNG ────────────────────────────────────

# Start SearXNG (search engine for MCP)
searxng-up:
  docker compose -f docker/searxng/docker-compose.yml up -d

# Stop SearXNG
searxng-down:
  docker compose -f docker/searxng/docker-compose.yml down

# View SearXNG logs
searxng-logs:
  docker compose -f docker/searxng/docker-compose.yml logs -f

# Generate a secret key for SearXNG
searxng-key:
  @openssl rand -hex 32

# ── Help ────────────────────────────────────────────────

default:
  @just --list
