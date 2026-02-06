---
name: code-review
description: Review code changes from GitHub PR or local branch
argument-hint: "[PR number or URL]"
allowed-tools: Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh pr checkout:*), Bash(git diff:*), Bash(git log:*), Bash(git branch --show-current), Bash(git status:*), Bash(git symbolic-ref:*), Read(*)
---

Review code changes based on the provided argument ($1):

- If $1 is a full GitHub PR URL (e.g., https://github.com/owner/repo/pull/123): review that PR
- If $1 is a PR number: review that PR in the current repository
- If $1 is empty: review the diff between current branch and default branch

## Review Process

### For GitHub PR Review

#### 1. Fetch PR Information

- Extract the PR number from the URL or use the provided number
- Use `gh pr view <number>` to fetch PR details (title, description, author, status, checks)

#### 2. Analyze Code Changes

- Use `gh pr diff <number>` to get the code changes
- Check out the PR branch using `gh pr checkout <number>` if needed for deeper analysis

### For Local Branch Review (when no PR specified)

#### 1. Determine Default Branch

- Use `git symbolic-ref refs/remotes/origin/HEAD` to get the default branch name

#### 2. Analyze Code Changes

- Use `git diff <default-branch>..HEAD` to get the code changes
- Use `git log <default-branch>..HEAD` to get commit history

## Code Review Focus Areas

- Code quality and adherence to best practices
- Potential bugs or security issues
- Performance considerations
- Test coverage (check if tests are included/modified)
- Documentation updates (if needed)
- Suggestions for improvement

## Notes

- For PR reviews: if checkout is needed, remember to return to the original branch after the review
- For local branch reviews: ensure the current branch is ahead of the default branch
- Format the review with clear sections and actionable feedback
