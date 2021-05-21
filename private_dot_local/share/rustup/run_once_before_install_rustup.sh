#!/bin/sh -e

export CARGO_HOME="${CARGO_HOME:-${XDG_DATA_HOME:-~/.local/share}/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-${XDG_DATA_HOME:-~/.local/share}/rustup}"
export PATH="$CARGO_HOME/bin:$PATH"

if [ -z "$(find "$RUSTUP_HOME/toolchains" -maxdepth 1 -name "stable-*" -print -quit)" ]; then
  if [ ! "$(command -v rustup)" ]; then
    echo "Installing rustup and stable Rust toolchain..."
    curl -sS https://sh.rustup.rs | sh -s -- -y --no-modify-path
  else
    echo "Installing stable Rust toolchain..."
    rustup install stable
  fi

  echo "Installing additional toolchain components..."
  for comp in rls rust-analysis rust-src; do
    rustup component add "$comp"
  done
fi

installed=$(cargo install --list | grep -o '^\S\+')
for addon in binutils bloat edit expand outdated sweep update watch; do
  if ! echo "$installed" | grep -wq $addon; then
    wanted="$addon $wanted"
  fi
done
if [ -n "$wanted" ]; then
  echo "Installing Cargo add-ons..."
  for addon in $wanted; do
    cargo install "cargo-$addon"
  done
fi

# vi: ft=sh
