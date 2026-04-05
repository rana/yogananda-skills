---
name: topology
description: Parallel search topology status and control. Manages multi-session hypothesis space exploration.
argument-hint: "[status|spawn|rebalance|report]"
---

## Search Topology

gstack-inspired parallel session orchestration. Multiple Claude sessions explore different regions of hypothesis space. Sessions that find signal get child regions spawned; sessions that find nothing get reallocated.

**Command:** $ARGUMENTS

### Commands

| Command | Action |
|---------|--------|
| `status` | Current topology state — regions, sessions, findings |
| `spawn <region>` | Manually spawn a session for a region |
| `rebalance` | Trigger rebalancing based on current findings |
| `report` | Full report with findings summary |

### Architecture

```
Orchestrator (scripts/search_topology.py)
    ├── Session 1: GC, tau=(5,13,21)
    ├── Session 2: NQ, tau=(5,13,21)
    ├── Session 3: GC, tau=(5,10,21,63,126,252)
    └── ...
```

**State file:** `~/.claude/firm-v5-topology-state.json`

Sessions communicate findings through the shared state file. The orchestrator:
1. Monitors state changes
2. Spawns sessions up to `max_sessions` limit
3. Prioritizes regions adjacent to regions with findings
4. Spawns child regions when parents find signal

### Usage

Start orchestrator:
```bash
python scripts/search_topology.py --regions scripts/example_regions.json --max-sessions 4
```

Check status:
```bash
python scripts/search_topology.py --status
```

### Session Protocol

Each session receives:
1. Region assignment (instrument, tau, extractions)
2. Task: profile, validate, report findings
3. Protocol for writing to shared state

Sessions should:
- Run `/phase EXPLORE`
- Compute profiles for assigned region
- Write findings to state file
- Mark region complete when done

### Findings Format

```json
{
  "extraction": "state_volatility",
  "grade_0": 1.56,
  "stability": 0.60,
  "pf": 5.96,
  "timestamp": "2024-01-15T14:30:00"
}
```

### Rebalancing Rules

1. **Finding boost:** Regions with findings boost priority of sibling regions (same instrument, different tau)
2. **Child spawning:** Completed regions with findings spawn child regions with tau variations
3. **Priority decay:** Regions with no findings after completion get priority reduced

## Output

For `status`:
- Active sessions count
- Pending/running/completed regions
- Total findings

For `report`:
- All findings grouped by instrument
- Best extraction per instrument
- Recommended next regions to explore

What patterns are emerging across the topology?
