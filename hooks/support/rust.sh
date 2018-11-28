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
  info "Installing rustup and nightly Rust..."
  curl https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain nightly
  info "Installing stable Rust..."
  rustup install stable
  info "Adding additional toolchain components..."
  for toolchain in nightly stable; do
    rustup component add --toolchain="$toolchain" rust-src rust-analysis rls-preview clippy-preview rustfmt-preview llvm-tools-preview
  done
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
