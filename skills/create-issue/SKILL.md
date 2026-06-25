---
name: create-issue
description: Creates structured repo issues using the TEMPLATE.md issue template. Use when the user says "create an issue", "file a bug", "new feature request", "track this as an issue", "write an issue for", or any request that results in a new issue file in docs/issues/.
---

# Create Issue

Creates a new issue file in `docs/issues/` using the repo's issue template. Walks through each section of the template with the user, filling in content one step at a time.

## When to Use

- User says "create an issue", "file a bug", "new feature", "feature request"
- User describes a problem or feature that should be tracked
- User asks to "write an issue for [something]"

**Do NOT use when:**
- The user is editing an existing issue file
- The user wants to create a template (use `TEMPLATE.md` editing instead)

## Workflow

### 1. Find the Template

Check if `docs/issues/TEMPLATE.md` exists in the current repo. If it does, use that. If not, fall back to the bundled default template at `TEMPLATE.md` in this skill directory.

### 2. Read the Template

Read the template to understand the structure. The template defines the sections the issue will contain.

### 3. Determine the Issue Type

Ask the user what type of issue this is (e.g., "Bug", "Feature", "Chore", "Refactor", "Docs"). If they don't specify, ask.

### 4. Gather Content Section by Section

For each section in the template (skip the instructions blockquote), ask the user for the content. Use the `interview-me` skill pattern — ask one question at a time, propose a draft for the user to react to. Do NOT batch all questions upfront.

Sections to fill (as defined by `TEMPLATE.md`):

- **Short Title** — derive from the issue title the user wants
- **Problem** — what's the current behavior or limitation?
- **Proposed Solution** — what should change? Break into sub-parts if needed
- **Acceptance Criteria** — how will we know it's done?
- **Files to Touch** — which files will likely change?
- **Out of Scope** — what's explicitly NOT being done?

For each section, propose a draft and let the user refine. Do not write the file until all sections are confirmed.

### 5. Generate the Filename

Convert the title to a kebab-case filename:

```
{short-title-slug}.md
```

### 6. Create the Issue File

Create `docs/issues/` if it doesn't exist. Write the filled-out template to `docs/issues/{filename}`. Remove the instructions blockquote. Present the file to the user for confirmation before writing.

## Output

A markdown issue file at `docs/issues/{short-title-slug}.md` with all template sections filled in.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I can just quickly write this issue" | Using the template ensures consistency and completeness. Missing sections (Out of Scope, Acceptance Criteria) lead to scope creep and unclear definition of done. |
| "I'll fill in the details later" | Future-you won't. Fill it in now or file a tracking issue to fill it in. |
| "Not all sections apply" | Skip them then. The template guides completeness but doesn't mandate filling every section. |
| "I already know what goes in each section" | Great — dictate them one by one and I'll write the drafts for your confirmation. |
| "This is too small for the template" | Small issues benefit most from clear scope. A few words per section is fine. |

## Red Flags

- Writing the issue file without user confirmation on each section
- Filling in sections with guesses instead of asking the user
- Batching all questions upfront instead of going section by section
- Skipping the "Out of Scope" section
- Not removing the instructions blockquote from the final file
- Creating the file without showing it to the user for final review

## Verification

- [ ] `docs/issues/TEMPLATE.md` exists and was read
- [ ] Each template section was presented to the user with a draft
- [ ] The user confirmed the content before writing
- [ ] The instructions blockquote was removed from the final file
- [ ] The file was saved to `docs/issues/{short-title-slug}.md`
- [ ] The user confirmed the final file is correct
