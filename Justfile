setup:
    #!/usr/bin/env bash
    set -e
    SKILLS_DIR="$(pwd)/.agents/skills"
    for skill_dir in "$SKILLS_DIR"/*/; do
        name=$(basename "$skill_dir")
        ln -sfn "$skill_dir" "$HOME/.agents/skills/$name"
    done
    ln -sfn "$SKILLS_DIR" .claude/skills
    echo "Done. Skills linked to ~/.agents/skills/ and .claude/skills -> .agents/skills/"
