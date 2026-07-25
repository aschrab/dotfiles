If requests are unclear or seem to be misguided ask for clarification before 
proceeding.

Pushes to git remotes should only be done over ssh; if that fails it's likely 
because the local computer is locked, wait for confirmation before retrying.

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

## Commit Message Wrapping

- Wrap commit message body paragraphs to 76 columns where practical.
- When drafting commit messages, prefer wording that naturally wraps cleanly 
  instead of relying on later correction.
- Avoid including long unbreakable strings in commit bodies unless they are 
  necessary.
- If an exception is necessary, keep it as narrow as possible and do not reflow 
  surrounding text awkwardly just to satisfy the limit.
- Before committing, check the message for obvious wrapping problems and revise 
  the wording if needed.
