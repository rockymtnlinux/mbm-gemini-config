# <Repository Name> - AI Development Instructions

## Upstream Guidelines

This repository adheres to the global engineering standards and 10-step development lifecycle defined in [mbm-gemini-config](https://github.com/rockymtnlinux/mbm-gemini-config/blob/main/GLOBAL_GUIDELINES.md).

---

## Read First

- `README.md` (Project Overview)
- Local documentation in `docs/`
- Relevant GitHub issue and acceptance criteria
- Existing unit/integration tests in the affected module

---

## Architecture Rules

- <List key architectural patterns, frameworks, and system-of-record details here>

---

## Safety Rules

- Never commit `.env`, credentials, local database files, caches, or user-specific paths.
- Do not add external network calls, cloud services, or telemetry without an approved issue.
- Do not run destructive Git commands (e.g. force push to main, hard resets without approval).
- Do not commit or push without explicit user approval.

---

## Development & Quality Rules

- **Adhere to Global Lifecycle**: Follow the 10-step development lifecycle in [mbm-gemini-config](https://github.com/rockymtnlinux/mbm-gemini-config/blob/main/GLOBAL_GUIDELINES.md).
- **Scope**: Keep changes minimal, atomic, and strictly scoped to the active issue.
- **Assumptions**: State assumptions and provide a file-level plan before editing.
- **Testing**: Add or update automated tests for all behavior changes.
- **Validation**: Validate changes locally with project test runners and linters before committing.
