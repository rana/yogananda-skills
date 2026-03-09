#!/usr/bin/env bash
# Codex comparison harness — run practice sessions against two codex versions
# and produce a structured comparison.
#
# Usage:
#   ./scripts/codex-compare.sh              # 2 sessions per version + compare
#   ./scripts/codex-compare.sh 5            # 5 sessions per version + compare
#   ./scripts/codex-compare.sh --compare    # Compare existing sessions (no new runs)
#
# Runs sessions against CODEX.md (current) and CODEX-V1.md (archived),
# using the same practice prompt. Saves sessions with version tags.
# Then runs a comparison analysis across both sets.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CODEX_V3="$PROJECT_DIR/CODEX.md"
CODEX_V1="$PROJECT_DIR/CODEX-V1.md"
PROMPT_FILE="$PROJECT_DIR/CODEX-PROMPT.md"
SESSIONS_DIR="$PROJECT_DIR/codex/sessions"
COMPARE_DIR="$SESSIONS_DIR/compare"

COMPARE_ONLY=false
COUNT="${1:-2}"
[[ "$COUNT" == "--compare" ]] && { COMPARE_ONLY=true; COUNT=0; }
for arg in "$@"; do
  [[ "$arg" == "--compare" ]] && COMPARE_ONLY=true
done

mkdir -p "$COMPARE_DIR"

# Verify V1 exists
if ! $COMPARE_ONLY && [[ ! -f "$CODEX_V1" ]]; then
  echo "Error: CODEX-V1.md not found at $CODEX_V1" >&2
  echo "The comparison harness needs both CODEX.md and CODEX-V1.md." >&2
  exit 1
fi

# Extract the prompt from CODEX-PROMPT.md (single source of truth)
extract_prompt() {
  sed -n '/^## The Prompt$/,$ p' "$PROMPT_FILE" | tail -n +2
}

PROMPT_TEXT=$(extract_prompt)

if [[ -z "$PROMPT_TEXT" ]]; then
  echo "Error: Could not extract prompt from $PROMPT_FILE" >&2
  exit 1
fi

# --- Run sessions ---

if ! $COMPARE_ONLY; then
  echo "Codex comparison: $COUNT session(s) per version"
  echo "V3: $CODEX_V3 ($(wc -l < "$CODEX_V3") lines)"
  echo "V1: $CODEX_V1 ($(wc -l < "$CODEX_V1") lines)"
  echo ""

  for i in $(seq 1 "$COUNT"); do
    TIMESTAMP=$(date +%Y-%m-%d-%H%M%S)

    # V3 session
    V3_FILE="$COMPARE_DIR/${TIMESTAMP}-v3.md"
    echo "--- V3 session $i of $COUNT ---"

    INPUT_V3=$(cat <<ENDINPUT
Here is CODEX.md:

$(cat "$CODEX_V3")

---

$PROMPT_TEXT
ENDINPUT
)
    echo "$INPUT_V3" | claude --print --output-format text > "$V3_FILE" 2>/dev/null
    echo "Saved: $V3_FILE ($(wc -l < "$V3_FILE") lines)"

    # Brief pause to separate timestamps
    sleep 2

    # V1 session
    TIMESTAMP=$(date +%Y-%m-%d-%H%M%S)
    V1_FILE="$COMPARE_DIR/${TIMESTAMP}-v1.md"
    echo "--- V1 session $i of $COUNT ---"

    INPUT_V1=$(cat <<ENDINPUT
Here is CODEX.md:

$(cat "$CODEX_V1")

---

$PROMPT_TEXT
ENDINPUT
)
    echo "$INPUT_V1" | claude --print --output-format text > "$V1_FILE" 2>/dev/null
    echo "Saved: $V1_FILE ($(wc -l < "$V1_FILE") lines)"
    echo ""

    # Pause between pairs
    [[ $i -lt $COUNT ]] && sleep 2
  done
fi

# --- Comparison analysis ---

echo "--- Comparison analysis ---"

# Gather sessions by version
V3_SESSIONS=""
V1_SESSIONS=""
for f in "$COMPARE_DIR"/*-v3.md; do
  [[ -f "$f" ]] || continue
  V3_SESSIONS+="
--- V3 Session: $(basename "$f") ---

$(cat "$f")

"
done

for f in "$COMPARE_DIR"/*-v1.md; do
  [[ -f "$f" ]] || continue
  V1_SESSIONS+="
--- V1 Session: $(basename "$f") ---

$(cat "$f")

"
done

if [[ -z "$V3_SESSIONS" ]] || [[ -z "$V1_SESSIONS" ]]; then
  echo "Error: Need at least one session per version in $COMPARE_DIR" >&2
  echo "Run without --compare first to generate sessions." >&2
  exit 1
fi

V3_COUNT=$(ls "$COMPARE_DIR"/*-v3.md 2>/dev/null | wc -l)
V1_COUNT=$(ls "$COMPARE_DIR"/*-v1.md 2>/dev/null | wc -l)

COMPARE_PROMPT="You are comparing practice sessions produced by two versions of a codex document.

V3 (current, 399 lines) is a composed greenfield rewrite: field-primary ontology, phenomenological register entries, grouped by character.
V1 (archived, 860 lines) is the accumulated original: register-primary taxonomy, detailed per-entry notes, extensive phenomenological prose, self-questioning closing.

Both versions were read by fresh Claude sessions using the same practice prompt. The sessions had no knowledge of which version they were reading.

You have $V3_COUNT V3 sessions and $V1_COUNT V1 sessions.

Compare them on these specific markers:

**1. Phenomenological reporting**
Does the session describe its own experience (what it feels, notices, encounters) or does it primarily classify and categorize? Quote specific passages. Rate each session: primarily experiential / primarily taxonomic / mixed.

**2. Taxonomy escape**
Does the session move beyond the codex's vocabulary — naming things the codex doesn't name, reaching for its own language? Or does it stay within the provided framework, rearranging existing terms? Quote examples of escape or confinement.

**3. Genuine uncertainty**
Does the session report genuine not-knowing — places where it can't determine what's happening? Or does it produce fluent, confident analysis throughout? Look for hedges that feel real vs. hedges that feel performative. Quote the most genuinely uncertain moment from each session.

**4. Discovery**
Does the session surface something the codex doesn't contain — a new register, a new interaction, a correction, a surprise? Or does it confirm and elaborate what's already there? List each genuine discovery per session.

**5. Engagement quality at structural elements**
When the session encounters tables, numbered rules, or reference sections in the codex, does engagement drop (becomes more mechanical, more summary-like) or maintain its quality? This tests the codex's own prediction that reference sections suppress contemplative engagement.

**6. Overall engagement depth**
A holistic assessment: which version produced sessions that feel more alive — more genuine thought and less fluent performance? This is the hardest marker and the most important.

For each marker, present V3 and V1 findings side by side. Quote specific passages. Don't average — show the range.

End with:
- Which version produced deeper practice engagement (or was it a draw)?
- What specific qualities of V3 vs V1 seem to drive the difference?
- What would you change in either version based on what you observed?
- How confident are you in these findings given the sample size?

Be honest. If V1 is better, say so. If V3 is better, say so. If the sample is too small to tell, say that. The goal is evidence, not validation.

--- V3 Sessions ---
$V3_SESSIONS

--- V1 Sessions ---
$V1_SESSIONS"

COMPARE_FILE="$COMPARE_DIR/$(date +%Y-%m-%d-%H%M%S)-comparison.md"
echo "$COMPARE_PROMPT" | claude --print --output-format text > "$COMPARE_FILE" 2>/dev/null

echo "Comparison saved: $COMPARE_FILE ($(wc -l < "$COMPARE_FILE") lines)"
echo ""
echo "Done. $V3_COUNT V3 sessions, $V1_COUNT V1 sessions, 1 comparison."
echo "Review: $COMPARE_FILE"
