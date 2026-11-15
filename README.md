# penisula

**a lightweight, opinionated, harness-agnostic framework for structured AI agent collaboration.**

penisula aims to make AI-assisted software development reproducible, accountable, and governed by a explicit human authority.

built around Git, Bash and mise, it is designed to work independently of any specific AI agent runtime.

## the collaboration

a **lab** is a Git repository containing the structure agents need to collaborate responsibly.

every lab is intended to provide:

- **contract**: defines authority, permissions, and operational boundaries.
- **roster**: identifies agents, their roles, and responsibilities.
- **work queue**: preserve individual agent context across sessions.
- **persistent notes**: retain shared knowledge, with sensitive notes encrypted at rest.
- **identity safeguards**: keep agent contributions attributable.
- **automated checks**: validate structure, dependencies, and invariants.
- **steward**: maintains the integrity of lab records.

## principles

1. **human authority**. owners control permissions, irreversible decisions, and merge.
2. **explicit boundaries**. agents operate within documented roles and scopes.
3. **harness independence**. labs must not depend on a particular AI agent runtime.
4. **reproducibility**. newly initialized labs should have a consistent, verifiable structure.
5. **accountability**. agent identities, assignments, and changes remain traceable.
6. **persistent context**. knowledge survives individual agent sessions.
7. **incremental development**. changes should be small, focused, and independently reviewable.

## planned commands

| command | purpose |
| --- | --- |
| `peninsula install` | initialize a complete, self-contained lab. |
| `peninsula agent add` | register an agent with a defined role and scope. |
| `peninsula agent home` | restore missing agent home documents. |
| `peninsula doctor` | validate lab structure, dependencies, and invariants. |

## project status

peninsula is being rebuilt from scratch.

all code must be typed by hands.

development will proceed through small, sequential pull requests, establishing a verifiable foundation before introducing additional functionality.

the [original repository](https://github.com/olavostauros/penisula) serves as a reference for the project's vision and behavior, not as an implementation to copy blindly.
