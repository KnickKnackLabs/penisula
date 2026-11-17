# penisula

`penisula` is a [shiv](https://github.com/KnickKnackLabs/shiv)-style tool: a
git repo with a `mise.toml` and executable tasks in `.mise/tasks/`. Installed,
it scaffolds and maintains **labs** — home bases for the agents of a project,
with a contract, a roster, a work queue, encrypted notes and a steward. The
`README.md` holds the vision.

This repository is the tool, not a lab: it has no `.agents/` of its own, no
roster and no contract. The lab architecture lands in `scaffold/`.

## Rebuild rules

penisula is being rebuilt from scratch:

- **One file per pull request.** Every change adds a single file — small,
  focused and independently reviewable. Edits to existing files happen only
  to wire that file in (a task's tool pin in `mise.toml`, a test's helper).
- **Typed by hand.** The [original repository](https://github.com/olavostauros/penisula)
  is a reference for vision and behavior, not a source to copy. Do not
  bulk-port its files.
- **Foundation before functionality.** A task lands only once the checks
  that exercise it can run.
- **Conventional commits** — `feat:`, `fix:`, `docs:`, `test:`, `refactor:`,
  `chore:` — with no footers and no tool attribution.

## Layout

As the rebuild proceeds, the repo takes the standard tool shape:

- `mise.toml` — settings now; tool pins, registries and lint config arrive
  with the tasks that need them.
- `.mise/tasks/` — the command surface (`install`, `agent add`, `agent
  home`, `doctor`) plus dev tasks (`test`, `validate`).
- `lib/` — shared Bash sourced by tasks; keep tasks command-shaped and put
  shared logic here.
- `scaffold/` — the payload `penisula install` renders into a new lab.
- `test/` — BATS. Tests call tasks through `mise run`, never raw scripts.

Commits land as the owner: there is no roster and no identity guard on this
repo.
