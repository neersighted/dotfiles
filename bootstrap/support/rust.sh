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
  info "Installing rustup..."
  curl https://sh.rustup.rs | sh -s -- -y --no-modify-path
  info "Adding nightly toolchain..."
  rustup default nightly
  info "Adding additional toolchain components..."
  for toolchain in nightly stable; do
    for tool in rust-src rust-analysis rls clippy rustfmt miri llvm-tools-preview; do
      rustup component add --toolchain="$toolchain" "$tool" || true # ignore failures
    done
  done
else
  info "Updating Rust and rustup..."
  rustup update
fi

if command -v cargo-install-update >/dev/null; then
  info "Updating cargo packages..."
  cargo install-update -a -g
fi
