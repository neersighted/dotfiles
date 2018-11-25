# shellcheck shell=sh

toolset_subsection "fzf"

go_get "github.com/junegunn/fzf"

if [ ! -L "$HOME/.local/bin/fzf-tmux" ]; then
  info "Linking fzf-tmux..."
  ln -sf "$GOPATH/src/github.com/junegunn/fzf/bin/fzf-tmux" "$HOME/.local/bin/fzf-tmux"
fi
