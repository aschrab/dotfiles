If requests are unclear or seem to be misguided ask for clarification before 
proceeding.

Pushes to git remotes should only be done over ssh; if that fails it's likely 
because the local computer is locked, wait for confirmation before retrying.

When opening pull/merge requests make sure to reference relevant issue numbers.

## Commit Discipline

Multi-step implementations must be split into separate commits, one commit per
step/phase. Do not batch unrelated or later planned steps into the same diff.

If you present or adopt a multi-step implementation plan, each plan step must
be completed as its own commit.

Requirements:
- Do not combine multiple plan steps into one commit.
- Before making edits, map planned steps to intended commits.
- After completing each step, create its commit before starting the next one.
- Each commit message must include a subject and a wrapped body explaining
  what changed and why.
- Wrap commit message paragraphs to 76 columns unless impractical.

“Phase” and “step” are literal: if the plan has 5 implementation steps, the
default expectation is 5 commits unless the user explicitly approves combining
them.

Do not push commits unless explicitly asked to do so or to open a pull/merge 
request. Existence of a pull/merge request does **not** mean that you should 
automatically update it. You are not allowed to force push unless explicitly 
demanded to do so, with confirmation.

## Commit Message Authoring

- Do not use `git commit -m` for commit messages.
- Write every commit message to a temporary file and pass it with
  `git commit --file <path>`.
- This applies to both normal commits and amended commits.
- Use the temporary file approach even for short messages so shell
  escaping is never part of commit message authoring.
- When a commit message contains backticks, quotes, backslashes, or
  other shell-sensitive characters, treat that as ordinary text in the
  file rather than trying to escape it for the shell.
- After writing the message file, inspect its contents before running
  `git commit`.
- The message file should contain:
  - a single-line subject
  - a blank line
  - one or more explanatory body paragraphs wrapped to 76 columns where
    practical
- Remove the temporary file after the commit succeeds.
- When the commit is being made as part of addressing an issue, reference the 
  issue in th commit message.
