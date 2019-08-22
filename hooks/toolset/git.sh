# shellcheck shell=sh

toolset_subsection "Git"

go_get "github.com/mkchoi212/fac@latest"
cargo_install "git-interactive-rebase-tool"

fetch_url "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" "$HOME/.local/bin/diff-so-fancy" true
fetch_url "https://raw.githubusercontent.com/kamranahmedse/git-standup/master/git-standup" "$HOME/.local/bin/git-standup" true
fetch_url "https://raw.githubusercontent.com/paulirish/git-open/master/git-open" "$HOME/.local/bin/git-open" true
fetch_url "https://raw.githubusercontent.com/paulirish/git-recent/master/git-recent" "$HOME/.local/bin/git-recent" true

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
