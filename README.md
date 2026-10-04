# MBM Gemini & Antigravity Configuration

Centralized repository for global AI agent guidelines, development lifecycles, reusable skills, and repository configuration templates across all MBM projects.

---

## Structure

- **[`GLOBAL_GUIDELINES.md`](./GLOBAL_GUIDELINES.md)**: Universal engineering standards ("3Cs"), shell execution rules, Git/GitHub CLI workflows, and the standard 10-step development lifecycle.
- **[`skills/`](./skills/)**: Shared Antigravity skills (e.g. `create_pr` with standardized PR body templates).
- **[`templates/`](./templates/)**: Starter templates for repository-level `GEMINI.md` files and configurations.
- **[`scripts/`](./scripts/)**: Synchronization scripts to deploy configurations to local user directories (`~/.gemini/`).

---

## Local Synchronization

To synchronize this centralized configuration with your local Antigravity/Gemini environment (`~/.gemini/`):

```bash
bash.exe scripts/sync.sh
```

This will:
1. Copy `GLOBAL_GUIDELINES.md` to `~/.gemini/GEMINI.md`.
2. Copy shared skills from `skills/` to `~/.gemini/config/skills/`.

---

## Referencing in Repositories

When configuring a repository's `GEMINI.md`, reference this repository as the canonical source for development workflow and standards:

```markdown
## Development Workflow
Adhere to the global development standards and 10-step lifecycle defined in [mbm-gemini-config](https://github.com/rockymtnlinux/mbm-gemini-config/blob/main/GLOBAL_GUIDELINES.md).
```
