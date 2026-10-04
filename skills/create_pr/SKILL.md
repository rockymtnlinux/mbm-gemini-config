---
name: create_pr
description: Creates a standardized Pull Request utilizing the official PR body template for the repository.
---

# Create PR Skill

When executing the workflow step to create a Pull Request for a repository, construct the Pull Request body using the official template provided below.

## Requirements before PR Creation:
1. Ensure all code issues and tests have passed.
2. Only create the PR when all issues have been resolved, or the user explicitly gives you permission.

## PR Body Template:

```markdown
## Intent
- Issue:
- Problem being solved:
- Acceptance criteria:
- Non-goals:

## Pre-implementation plan
- Summary of proposed approach:
- Alternatives considered:
- Why this approach was chosen:

## Change set
- Changed files:
- Architectural areas touched:
- Data/schema/config changes:
- External integration changes:

## Validation
- Tests added/updated:
- Commands run:
- Results:
- Manual verification:

## Walkthrough
- Step-by-step changes made:
- Deviations from plan:
- Follow-up work intentionally deferred:

## Risk ledger
- Edge cases considered:
- Known limitations:
- Rollback notes:
- Reviewer focus areas:
```

## Action
Write the formatted PR body content to a temporary file (e.g. in your scratch directory) and execute `gh.exe pr create --title "<title>" --body-file "<path_to_body_file>"`. Prompt the user for explicit approval before creating the PR.
