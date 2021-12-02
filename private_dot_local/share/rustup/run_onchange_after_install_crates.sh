#!/bin/sh -e

crates="
cargo-audit
cargo-asm
cargo-binutils
cargo-bloat
cargo-depgraph
cargo-edit
cargo-expand
cargo-feature
cargo-fuzz
cargo-release
cargo-sort
cargo-supply-chain
cargo-tarpaulin
cargo-outdated
cargo-udeps
cargo-update
cargo-watch
flamegraph
"

installed=$(cargo install --list | { grep -o '^\S\+' || true; })
for crate in $crates; do
  if ! echo "$installed" | grep -wq "$crate"; then
    wanted="$crate $wanted"
  fi
done

if [ -n "$wanted" ]; then
  echo "Installing crates..."
  for crate in $wanted; do
    cargo install --force --locked "$crate"
  done
fi
