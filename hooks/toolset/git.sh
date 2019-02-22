# shellcheck shell=sh

toolset_subsection "Git"

go_get "github.com/mkchoi212/fac"
cargo_install "git-interactive-rebase-tool"
pipx_install "icdiff" "git+https://github.com/jeffkaufman/icdiff.git"

go_get "github.com/github/hub"
pipx_install "legit"

npm_install "diff-so-fancy"
npm_install "git-open"
npm_install "git-recent"
npm_install "git-standup"

if ! git credential-netrc >/dev/null 2>&1 && [ $? -eq 255 ]; then
  NETRC_BIN="$HOME/.local/bin/git-credential-netrc"
  NETRC_PATHS="/usr/local/share/git-core/contrib/credential/netrc/git-credential-netrc /usr/share/doc/git/contrib/credential/netrc/git-credential-netrc"

  for path in $NETRC_PATHS; do
    if [ ! -L "$NETRC_BIN" ] && [ -x "$path" ] ; then
      info "Linking git-credential-netrc..."
      ln -sf "$path" "$NETRC_BIN"
      break
    fi
    if [ ! -f "$NETRC_BIN" ] && [ -f "$path" ]; then
      info "Copying git-credential-netrc..."
      cp -f "$path" "$NETRC_BIN"
      chmod +x "$NETRC_BIN"
      break
    fi
  done
fi

mkdir -p "$XDG_DATA_HOME/tig"
