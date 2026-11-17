#!/usr/bin/env bats

load test_helper
bats_require_minimum_version 1.5.0

write_passing_test() {
  local path="$1" name="$2"
  mkdir -p "$(dirname "$path")"
  printf '%s\n' \
    '#!/usr/bin/env bats' \
    "@test \"$name\" {" \
    '  true' \
    '}' > "$path"
}

write_barrier_test() {
  printf '%s\n' '#!/usr/bin/env bats' > "$1"
  cat >> "$1" <<BATS
@test "$2 sees $3" {
  touch "\$BARRIER_DIR/$2"
  for _ in {1..50}; do
    [ ! -e "\$BARRIER_DIR/$3" ] || return 0
    sleep 0.05
  done
  false
}
BATS
}

@test "options-only runs use test/ as the default target" {
  run penisula test --jobs 1 --filter '^standard skeleton surfaces exist$'

  [ "$status" -eq 0 ]
  [[ "$output" == *'1..1'* ]]
  [[ "$output" == *'ok 1 standard skeleton surfaces exist'* ]]
}

@test "an explicit target outside test/ runs instead of the default" {
  local target="$BATS_TEST_TMPDIR/explicit.bats"
  write_passing_test "$target" 'explicit target only'

  run penisula test --jobs 1 "$target"

  [ "$status" -eq 0 ]
  [[ "$output" == *'1..1'* ]]
  [[ "$output" == *'ok 1 explicit target only'* ]]
}

@test "a relative target resolves from the repository root" {
  cd "$BATS_TEST_TMPDIR"
  run penisula test --jobs 1 test/skeleton.bats --filter '^standard skeleton surfaces exist$'

  [ "$status" -eq 0 ]
  [[ "$output" == *'1..1'* ]]
}

@test "a whitespace-bearing target stays a single argument" {
  local target="$BATS_TEST_TMPDIR/space dir/passing test.bats"
  write_passing_test "$target" 'whitespace target'

  run penisula test --jobs 1 "$target"

  [ "$status" -eq 0 ]
  [[ "$output" == *'1..1'* ]]
  [[ "$output" == *'ok 1 whitespace target'* ]]
}

@test "separate test files run concurrently" {
  local probe_dir="$BATS_TEST_TMPDIR/probe"
  export BARRIER_DIR="$BATS_TEST_TMPDIR/barrier"
  mkdir -p "$probe_dir" "$BARRIER_DIR"

  write_barrier_test "$probe_dir/one.bats" one two
  write_barrier_test "$probe_dir/two.bats" two one

  run penisula test "$probe_dir"

  [ "$status" -eq 0 ]
}
