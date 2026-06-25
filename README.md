# ai-library

Reusable skills, agents, and commands for AI coding agents.

This is a personal collection of packaged workflows that AI agents
(Claude Code, Cursor, Copilot, etc.) can follow consistently. Each
skill encodes the steps, quality gates, and conventions a senior
engineer would follow for a given task.

## Repository Structure

```
ai-library/
  skills/          # Workflows with steps, exit criteria, and scripts
  agents/          # Personas with perspective and output format (coming soon)
  commands/        # Orchestration entry points (coming soon)
  AGENTS.md        # Guidance for AI agents working in this repo
```

## Skills

| Skill           | Description                                                              |
| --------------- | ------------------------------------------------------------------------ |
| create-issue    | Creates structured repo issues from a TEMPLATE.md or bundled default     |
| domain-transfer | Domain registration migration between providers while keeping sites live |

### Skill Anatomy

Each skill lives in `skills/<skill-name>/` and follows this layout:

```
skills/<skill-name>/
  SKILL.md              # Required: workflow definition with steps and gotchas
  scripts/              # Required: executable helper scripts
    <script>.sh         # Bash scripts (preferred)
  references/           # Optional: reference tables, per-provider docs
```

## Usage

TBD

## Adding a New Skill

1. Create `skills/<kebab-case-name>/SKILL.md` with frontmatter (name, description)
2. Add executable scripts under `scripts/`
3. Add reference docs under `references/` for context-heavy topics
4. Commit and push

See `AGENTS.md` for full conventions.

## License

MIT
