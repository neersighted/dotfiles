# shellcheck shell=sh

support_subsection "Rust"

if [ -z "$CARGO_HOME" ]; then
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
fi
if [ -z "$RUSTUP_HOME" ]; then
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
fi
export PATH="$CARGO_HOME/bin:$PATH"

if ! command -v rustup >/dev/null; then
  info "Installing rustup and Rust..."
  curl https://sh.rustup.rs | sh -s -- -y --no-modify-path
  info "Adding additional toolchain components..."
  rustup component add rust-src rust-analysis rls-preview clippy-preview rustfmt-preview llvm-tools-preview
else
  info "Updating Rust and rustup..."
  rustup update
fi

info "Generating rustup fish completion..."
rustup completions fish > "$XDG_CONFIG_HOME/fish/completions/rustup.fish"

if command -v cargo-install-update >/dev/null; then
  info "Updating cargo packages..."
  cargo install-update -a -g
fi
