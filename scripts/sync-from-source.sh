#!/usr/bin/env bash
#
# Sync skills and commands from ~/.claude/ into the plugin structure.
# Run this after editing skills in ~/.claude/skills/ to update the plugin.
#
# Usage: ./scripts/sync-from-source.sh [--dry-run]
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"
SOURCE_SKILLS="$HOME/.claude/skills"
SOURCE_COMMANDS="$HOME/.claude/commands"
SOURCE_SYSTEM="$HOME/.claude/SYSTEM.md"
SRF_PROJECT_SKILLS="$HOME/prj/srf-yogananda-teachings/.claude/skills"

DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

# Skills to exclude (project-specific, external symlinks, or not for distribution)
EXCLUDE_SKILLS=(
  "scratch"        # Project-specific backlog processor
  "neon-postgres"  # External symlink, not ours to distribute
)

is_excluded() {
  local name="$1"
  for excluded in "${EXCLUDE_SKILLS[@]}"; do
    [[ "$name" == "$excluded" ]] && return 0
  done
  return 1
}

echo "=== Cognitive Toolkit Plugin Sync ==="
echo "Source: $SOURCE_SKILLS"
echo "Target: $PLUGIN_DIR/skills/"
echo ""

# Sync skills
skill_count=0
for skill_dir in "$SOURCE_SKILLS"/*/; do
  skill_name="$(basename "$skill_dir")"

  if is_excluded "$skill_name"; then
    echo "  SKIP  $skill_name (excluded)"
    continue
  fi

  if [[ ! -f "$skill_dir/SKILL.md" ]]; then
    echo "  SKIP  $skill_name (no SKILL.md)"
    continue
  fi

  if $DRY_RUN; then
    echo "  WOULD COPY  $skill_name/"
  else
    mkdir -p "$PLUGIN_DIR/skills/$skill_name"
    cp -r "$skill_dir"/* "$PLUGIN_DIR/skills/$skill_name/"
    echo "  COPY  $skill_name/"
  fi
  skill_count=$((skill_count + 1))
done

# Sync SRF project-level skills (mission-specific)
if [[ -d "$SRF_PROJECT_SKILLS" ]]; then
  echo ""
  echo "Source: $SRF_PROJECT_SKILLS (SRF mission skills)"
  echo ""
  for skill_dir in "$SRF_PROJECT_SKILLS"/*/; do
    skill_name="$(basename "$skill_dir")"

    if [[ ! -f "$skill_dir/SKILL.md" ]]; then
      echo "  SKIP  $skill_name (no SKILL.md)"
      continue
    fi

    if $DRY_RUN; then
      echo "  WOULD COPY  $skill_name/ (SRF mission)"
    else
      mkdir -p "$PLUGIN_DIR/skills/$skill_name"
      cp -r "$skill_dir"/* "$PLUGIN_DIR/skills/$skill_name/"
      echo "  COPY  $skill_name/ (SRF mission)"
    fi
    skill_count=$((skill_count + 1))
  done
fi

echo ""
echo "Skills synced: $skill_count"

# Sync commands
echo ""
echo "Source: $SOURCE_COMMANDS"
echo "Target: $PLUGIN_DIR/commands/"
echo ""

command_count=0
for cmd_file in "$SOURCE_COMMANDS"/*.md; do
  [[ ! -f "$cmd_file" ]] && continue
  cmd_name="$(basename "$cmd_file")"

  if $DRY_RUN; then
    echo "  WOULD COPY  $cmd_name"
  else
    cp "$cmd_file" "$PLUGIN_DIR/commands/$cmd_name"
    echo "  COPY  $cmd_name"
  fi
  command_count=$((command_count + 1))
done

echo ""
echo "Commands synced: $command_count"

# Sync SYSTEM.md as the plugin's reference doc
if [[ -f "$SOURCE_SYSTEM" ]]; then
  if $DRY_RUN; then
    echo ""
    echo "WOULD COPY SYSTEM.md"
  else
    cp "$SOURCE_SYSTEM" "$PLUGIN_DIR/SYSTEM.md"
    echo ""
    echo "SYSTEM.md synced"
  fi
fi

echo ""
echo "=== Done ==="
echo "Total: $skill_count skills, $command_count commands"
if $DRY_RUN; then
  echo "(dry run — no files changed)"
fi
