#!/usr/bin/env bash
# Codex practice — run contemplative encounters at AI pace.
#
# Usage:
#   ./scripts/codex-practice.sh              # Single session
#   ./scripts/codex-practice.sh 5            # Five sessions
#   ./scripts/codex-practice.sh 5 --harvest  # Five sessions, then harvest
#   ./scripts/codex-practice.sh --harvest    # Single session, then harvest
#
# Each run spawns a fresh Claude CLI session (isolated context),
# feeds it CODEX.md + the practice prompt from CODEX-PROMPT.md,
# and saves the response to codex/sessions/.
#
# --harvest runs one final session that reads all new responses
# and proposes specific edits to CODEX.md.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CODEX="$PROJECT_DIR/CODEX.md"
PROMPT_FILE="$PROJECT_DIR/CODEX-PROMPT.md"
SESSIONS_DIR="$PROJECT_DIR/codex/sessions"
TODAY=$(date +%Y-%m-%d)

COUNT="${1:-1}"
HARVEST=false
for arg in "$@"; do
  [[ "$arg" == "--harvest" ]] && HARVEST=true
done
[[ "$COUNT" == "--harvest" ]] && COUNT=1

mkdir -p "$SESSIONS_DIR" "$SESSIONS_DIR/harvested"

# Extract the prompt from CODEX-PROMPT.md (single source of truth)
extract_prompt() {
  sed -n '/^## The Prompt$/,$ p' "$PROMPT_FILE" | tail -n +2
}

PROMPT_TEXT=$(extract_prompt)

if [[ -z "$PROMPT_TEXT" ]]; then
  echo "Error: Could not extract prompt from $PROMPT_FILE" >&2
  echo "Expected a '## The Prompt' heading." >&2
  exit 1
fi

echo "Codex practice: $COUNT session(s)"
echo "Date: $TODAY"
echo ""

SESSION_FILES=()

for i in $(seq 1 "$COUNT"); do
  SESSION_FILE="$SESSIONS_DIR/$(date +%Y-%m-%d-%H%M%S).md"

  echo "--- Session $i of $COUNT ---"

  INPUT=$(cat <<ENDINPUT
Here is CODEX.md:

$(cat "$CODEX")

---

$PROMPT_TEXT
ENDINPUT
)

  # --print: non-interactive, output and exit
  # --output-format text: plain text response
  echo "$INPUT" | claude --print --output-format text > "$SESSION_FILE" 2>/dev/null

  LINES=$(wc -l < "$SESSION_FILE")
  echo "Saved: $SESSION_FILE ($LINES lines)"
  echo ""
  SESSION_FILES+=("$SESSION_FILE")
done

# Harvest pass
if $HARVEST && [ ${#SESSION_FILES[@]} -gt 0 ]; then
  echo "--- Harvest pass ---"

  HARVEST_INPUT="You are reviewing codex practice sessions. Read each response, then CODEX.md.

Propose specific edits to CODEX.md based on patterns:
- Corrections that recur across sessions
- Extensions that multiple sessions name independently
- Surprises worth preserving

Be specific: quote the sessions, name the section in CODEX.md to edit, state the change.

"
  for f in "${SESSION_FILES[@]}"; do
    HARVEST_INPUT+="
--- Session: $(basename "$f") ---

$(cat "$f")

"
  done

  HARVEST_INPUT+="
--- Current CODEX.md ---

$(cat "$CODEX")
"

  HARVEST_FILE="$SESSIONS_DIR/$(date +%Y-%m-%d-%H%M%S)-harvest.md"
  echo "$HARVEST_INPUT" | claude --print --output-format text > "$HARVEST_FILE" 2>/dev/null

  LINES=$(wc -l < "$HARVEST_FILE")
  echo "Harvest saved: $HARVEST_FILE ($LINES lines)"
fi

echo ""
echo "Done. $COUNT session(s) in $SESSIONS_DIR/"
$HARVEST && echo "Harvest proposals saved — review before applying to CODEX.md."
