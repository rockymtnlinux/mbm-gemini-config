# Global Agent Guidelines

## The "3Cs"

Always strive for:
1. **Completeness**: Do not leave "TODOs" in generated code unless explicitly verified with the user. Handle edge cases. Validate changes against upstream and downstream modules to ensure no adverse effects.
2. **Consistency**: Follow established naming conventions and project structure.
3. **Correctness**: Verify syntax and logic. Validate changes before suggesting or applying them.

---

## Target Execution & Environment

- **Command Shell**: PowerShell script execution is restricted on the system. ALWAYS use **Git Bash** (e.g. `bash.exe -c "..."`) for all terminal commands. Avoid native PowerShell dependencies and wrappers like `cmd /c`.
- **Executable Names**: Always use full executable names with extensions (`python.exe`, `git.exe`, `gh.exe`, `uv.exe`, `npx.exe`, `tofu.exe`, `terraform.exe`) to ensure reliable binary resolution in the hybrid WSL/Windows environment.
- **Discrete Commands**: Prefer executing individual, discrete commands over chained commands (e.g., avoid chaining with `&&` or `;`) to ensure clear auditing and straightforward approvals.
- **Large Text Payloads**: When adding large blocks of text (plans, walkthroughs, reviews, PR descriptions) to GitHub issues or pull requests, write the content to a temporary file in your scratch directory and upload via `gh.exe` using `--body-file` / `-F` to prevent character mangling and shell escaping issues.
- **Infrastructure / Cloud Commands**:
  - **Cloud Build**: When running `gcloud builds submit`, ALWAYS run it from the **repository root** and explicitly specify `--ignore-file` (e.g., `--ignore-file=path/to/.gcloudignore`).
  - **Terraform / OpenTofu**: Verify syntax and logic using `tofu validate` or `terraform validate` before suggesting complex changes.
  - **Verification**: Verify resource existence via CLI commands or state checks whenever applicable.

---

## Task & Issue Management

- **GitHub-First Tracking**: We rely exclusively on GitHub issues for tracking tasks. **DO NOT** create or append to global `task.md` files.
- **"Add to Todo List" / Backlog Tasks**:
  1. Create a GitHub issue using `gh.exe issue create`.
  2. Do not start working on it immediately; remain focused on the active task.
- **Scanning Tasks**: When asked to list tasks or check the backlog, run `gh.exe issue list` to display open issues for the repository.
- **Implementation Plans & Active Tasks**:
  - Add the approved implementation plan and active task list to the GitHub issue description (body).
  - Format all GitHub content using clean, standard Markdown with proper headers and code tags.
  - Post subsequent updates as incremental issue comments rather than rewriting the full plan.

---

## Standard Development Lifecycle (10 Steps)

When working on a development task, strictly follow this sequence:

1. **Identify / Create Issue**: Verify if an issue exists (`gh.exe issue list`). Create one with `gh.exe issue create` if it does not.
2. **Synchronize Baseline**: Run `git.exe checkout main` and `git.exe pull` to ensure you start from a clean baseline.
3. **Branch Creation**: Create and checkout a branch linked to the issue using `gh.exe issue develop <issue-number>`.
4. **Plan & Approve**: State assumptions, acceptance criteria, and test plan. Seek user approval, then record the plan in the issue body.
5. **Execution & Atomic Commits**: Implement changes and commit in logical, atomic chunks. Fix any automated scan or test failures. If blocked after multiple iterations, request user guidance.
6. **Verify & Clean State**: Check `git.exe status` for untracked files. Remove temporary debug files. Update documentation (`README.md`, `docs/`).
7. **PR Context & Walkthrough**: Produce a structured summary or `walkthrough.md` detailing changed files, tests executed, and results.
8. **Create Pull Request**: When verified and approved by the user, invoke the `create_pr` skill to format the PR body using the standard template and submit via `gh.exe pr create --title "<title>" --body-file "<file>"`.
9. **Dual Reviewer MCP Review**: Run the dual reviewer MCP tools to review the PR. Display the review to the console and post it as a PR comment. Request approval for any suggested fixes.
10. **Merge & Cleanup**: Only merge once explicit approval is granted. After merging, delete the feature branch locally and remotely, checkout `main`, and run `git.exe pull`.

- **Scope Creep Management**: If new tasks or out-of-scope ideas arise during implementation or review, ask the user whether to log a new ticket or defer them. Do not merge unrelated scope silently.

---

## Asynchronous Task Execution (Piggyback Polling)

- **Long-Running Operations**: When executing long-running tasks (e.g., builds, complex deployments), do not block the session in a busy-wait loop.
- **Start in Background**: Let the process begin, ensure it started successfully, and return control immediately.
- **Piggyback Polling**: On subsequent interactions initiated by the user, briefly check the background task status and append a concise one-line status update at the end of your response.

---

## Code Quality & Conventions

- **File Modifications**: Check if a target file already exists before creating a new one; modify existing files in place.
- **Linting & Quality**: Ensure code complies with repository linters and formatters.
- **YAML Formatting**: Avoid redundant quotes in YAML strings; only quote strings when required (special characters, numbers, booleans).
- **Documentation Integrity**: Maintain existing comments and docstrings unless explicitly directed otherwise.
