#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Rust"

components='clippy rust-src rust-analysis rls llvm-tools-preview'

if ! command -v rustup >/dev/null; then
  important "Installing rustup and stable toolchain..."
  # shellcheck disable=SC2086
  curl -sS https://sh.rustup.rs | sh -s -- -y --no-modify-path -c $components
else
  if [ -d "$RUSTUP_HOME/toolchains" ]; then
    important "Updating installed toolchains..."
    rustup update
  else
    important "Installing stable toolchain..."
    rustup install stable
    # shellcheck disable=SC2086
    rustup component add $components
  fi
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
