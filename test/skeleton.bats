#!/usr/bin/env bats

load test_helper

@test "standard skeleton surfaces exist" {
  for path in \
    mise.toml \
    README.md \
    AGENTS.md \
    LICENSE \
    .gitignore \
    .github/workflows/test.yml \
    .mise/tasks/test \
    test/test_helper.bash \
    test/setup_suite.bash
  do
    [ -e "$REPO_DIR/$path" ]
  done
}

@test "public test task owns the complete BATS runner" {
  run grep -n '^exec bats ' "$REPO_DIR/.mise/tasks/test"
  [ "$status" -eq 0 ]
  [ ! -e "$REPO_DIR/libexec/test" ]
}

@test "public tasks provide examples through their real help" {
  while IFS= read -r task_file; do
    relative_path="${task_file#"$REPO_DIR/.mise/tasks/"}"
    task_name="${relative_path%/_default}"
    task_name="${task_name//\//:}"

    run penisula "$task_name" --help
    [ "$status" -eq 0 ]
    [[ "$output" == *"Examples:"* ]]
  done < <(find "$REPO_DIR/.mise/tasks" -type f -print | sort)
}
