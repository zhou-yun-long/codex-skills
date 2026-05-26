---
name: github-repo-publisher
description: Create, connect, and push local projects to GitHub repositories. Use when the user asks Codex to publish a project to GitHub, push a project to a GitHub repo, create a GitHub repository for the current project, initialize Git, set or inspect remotes, or handle first-time repository setup and push workflows.
---

# GitHub Repo Publisher

## Core Workflow

Use this workflow whenever the user wants a local project pushed to GitHub.

1. Inspect the local environment before making changes:
   - Run `scripts/inspect_repo.ps1` from this skill if PowerShell is available.
   - Also inspect `git status --short --branch` and `git remote -v` when `git` exists.
   - Check whether `gh` exists with `Get-Command gh` or `gh --version`.
   - If an app connector for GitHub is available, prefer it for GitHub API operations.

2. Protect the user's work:
   - Never revert or discard existing changes.
   - If the working tree contains unrelated files or generated artifacts, add a `.gitignore` first when appropriate.
   - Stage only files intended for the first publish unless the user explicitly asks to publish everything.

3. Decide the path:
   - If a remote exists, show the remote URL and ask the user to confirm using it unless they already named the target.
   - If no remote exists and the user provided `owner/repo`, create or connect to that repository.
   - If no remote exists and no target repo name is provided, choose a conservative repo name from the folder name and create a new GitHub repo when tooling and authentication allow it.
   - If repository creation is not possible from available tools, tell the user exactly what is missing and provide the shortest manual step needed.

## Preferred Tool Order

Use the safest available option in this order:

1. GitHub app or connector tools for remote GitHub operations.
2. GitHub CLI `gh` for `repo create`, auth checks, and push setup.
3. Native `git` for init, remote, add, commit, and push.
4. Manual fallback instructions only when the environment lacks required tools or authentication.

Do not claim the push succeeded unless the command or connector operation actually succeeded.

## No Remote Flow

When no `origin` exists:

1. Initialize Git if needed: `git init`.
2. Create `.gitignore` before staging when the project has generated outputs, caches, build folders, secrets, or dependency directories.
3. Create a repository:
   - With `gh`: `gh repo create <owner>/<repo> --private --source . --remote origin --push` or `--public` if the user requested public.
   - With connector tools: create the repo if such a tool exists, then use Git or connector file APIs to upload files.
4. Commit with a clear message, usually `Initial commit` or a user-provided message.
5. Push the current branch to `origin`.

Default visibility should be private unless the user asks for public.

## Existing Remote Flow

When a remote exists:

1. Report the current remote and branch.
2. If the user did not explicitly approve that remote, ask for confirmation before pushing.
3. Commit intended changes.
4. Push to the current branch, setting upstream if needed.

## Fallbacks

If `git` is missing:
- Try the GitHub connector if it can create files/commits directly.
- If no connector path can create the repository, explain that Git or GitHub Desktop/GitHub CLI is required for local push.

If `gh` is missing:
- Use the GitHub connector to create the repo when available.
- Otherwise ask the user to create an empty repo on GitHub, then provide the remote URL.

If authentication is missing:
- Run non-destructive auth status commands when available.
- Ask the user to authenticate with `gh auth login` or provide a repository URL they can access.

If repository creation succeeds but push fails:
- Preserve the local commit.
- Report the exact failure and the command to retry.

## Completion Report

End with:
- Repository URL.
- Branch pushed.
- Commit SHA or commit message when available.
- Any files deliberately excluded.
- Any remaining manual step if full automation was blocked.
