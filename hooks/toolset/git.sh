# shellcheck shell=sh

toolset_subsection "Git"

go_get "github.com/mkchoi212/fac"
cargo_install "git-interactive-rebase-tool"

go_get "github.com/github/hub"
pipx_install "legit"

npm_install "diff-so-fancy"
npm_install "git-open"
npm_install "git-recent"
npm_install "git-standup"

case $(uname) in
  Linux)
    if [ ! -f "$HOME/.local/bin/git-credential-netrc" ]; then
      info "Copying git-credential-netrc..."
      cp -f /usr/share/doc/git/contrib/credential/netrc/git-credential-netrc "$HOME/.local/bin/git-credential-netrc"
      chmod +x "$HOME/.local/bin/git-credential-netrc"
    fi
    ;;
  FreeBSD)
    if [ ! -L "$HOME/.local/bin/git-credential-netrc" ]; then
      info "Linking git-credential-netrc..."
      ln -sf /usr/local/share/git-core/contrib/credential/netrc/git-credential-netrc "$HOME/.local/bin/git-credential-netrc"
    fi
  ;;
esac

mkdir -p "$XDG_DATA_HOME/tig"