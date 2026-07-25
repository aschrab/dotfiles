If requests are unclear or seem to be misguided ask for clarification before 
proceeding.

Pushes to git remotes should only be done over ssh; if that fails it's likely 
because the local computer is locked, wait for confirmation before retrying.

## Commit Discipline

Multi-step implementations must be split into separate commits, one commit per
step/phase. Do not batch unrelated or later planned steps into the same diff.

Each commit message must include a subject and explanatory body, wrapped to
76 columns where practical.
