# AGENTS.md

This file provides guidance to AI coding agents (Claude Code, Cursor, Copilot, etc.)
when working with code in this repository.

## Repository Overview

A personal collection of reusable skills for AI coding agents. Skills are packaged
instructions and scripts that encode senior-engineer workflows.

## Directory Structure

```
skills/<skill-name>/
  SKILL.md              # Required: skill definition with frontmatter
  scripts/              # Required: executable helpers
    <script>.sh         # Bash scripts with set -e, cleanup traps
  references/           # Optional: detailed reference material
```

## Naming Conventions

- **Skill directory**: `kebab-case` (e.g. `domain-transfer`)
- **SKILL.md**: Always uppercase, always this exact filename
- **Scripts**: `kebab-case.sh` (e.g. `verify-dns.sh`)

## SKILL.md Format

```markdown
---
name: {skill-name}
description: One sentence, with "Use when" trigger conditions.
---

# {Skill Title}

Brief overview.

## Workflow

Numbered steps with exit criteria.

## Common Gotchas

Problems and their fixes in table form.

## Troubleshooting

Common issues.

## Present Results to User

Template for how to format results.
```

## Script Requirements

- Use `#!/bin/bash` shebang
- Use `set -e` for fail-fast
- Write status to stderr (`echo "Message" >&2`), output to stdout
- Include usage message if arguments are required
- Use `trap` to clean up temp files

## Skill Lifecycle

An agent encountering a matching task should:

1. Load the skill via `SKILL.md`
2. Follow the workflow steps in order
3. Verify exit criteria before proceeding
4. Present results using the skill's output template

## Adding a New Skill

1. Create the skill directory under `skills/`
2. Write `SKILL.md` with frontmatter
3. Add at least one executable script in `scripts/`
4. Update the skill table in `README.md`
5. Commit
