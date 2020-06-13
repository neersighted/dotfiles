#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Rust"

if ! command -v rustup >/dev/null; then
  important "Installing new Rust toolchain..."
  curl -sS https://sh.rustup.rs | sh -s -- -y --no-modify-path -c rust-src rust-analysis rls miri llvm-tools-preview
else
  important "Updating Rust toolchain..."
  rustup update
fi

if command -v cargo-install-update >/dev/null; then
  important "Updating Rust packages..."
  cargo install-update -a -g
fi

cargo_install "cargo-binutils"
cargo_install "cargo-bloat"
cargo_install "cargo-edit"
cargo_install "cargo-expand"
cargo_install "cargo-outdated"
cargo_install "cargo-sweep"
cargo_install "cargo-update"
cargo_install "cargo-watch"

# vi: ft=sh
