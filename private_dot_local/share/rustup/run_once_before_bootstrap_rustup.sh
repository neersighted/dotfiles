#!/bin/sh -e

export CARGO_HOME="${CARGO_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/rustup}"
export PATH="$CARGO_HOME/bin:$PATH"

if [ ! "$(command -v rustup)" ]; then
  echo "Installing rustup and stable Rust toolchain..."
  curl -sS https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain none
fi
