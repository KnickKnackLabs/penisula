#!/usr/bin/env bash
# Shared fixtures for penisula tests.

# Run a repo task through mise so tests exercise the real task path.
penisula() {
  cd "$REPO_DIR" && mise run -q "$@"
}
export -f penisula
