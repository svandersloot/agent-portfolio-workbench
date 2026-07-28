@AGENTS.md

`AGENTS.md` (imported above) is the single canonical operating contract. Operating
posture, the read-first sequence, source-of-truth order, live-system boundaries,
human-owned decisions, the risk scan, branch/worktree posture, validation, and the
handoff format all live there and are not restated here. This file adds only what is
specific to Claude Code.

## Claude Code Specifics

- Begin every planning or implementation task with the `AGENTS.md` → **Read First**
  sequence (`AGENTS.md` → `README.md` → `START-HERE.md` → `docs/toolkit-operating-model.md`
  → task-specific source docs). Use `docs/README.md` when you need to route to
  audience-specific material.
- Keep Claude-specific work bounded. Claude Code migration is not approval to write to
  ROVO Studio, Jira, or Confluence; the `AGENTS.md` live-system boundaries apply
  unchanged, including for any write-capable Atlassian MCP connector present in local
  tooling.
- Provide the Anthropic API key via the `ANTHROPIC_API_KEY` environment variable only —
  never in prompts, tracked files, issues, or pull requests.
- Run `.\scripts\Test-PrivateDataScan.ps1` before every `git add` or commit. Do not commit
  `data/raw/`, `.env`, or `config/confluence-pages.yml`.
