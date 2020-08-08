#!/bin/sh

set -e

# shellcheck source=_lib.sh
. "${XDG_DATA_HOME:-~/.local/share}/replicator/_lib.sh"

section "Git"

cargo_install "git-interactive-rebase-tool"
go_get "github.com/mkchoi212/fac"

github_sync "kamranahmedse/git-standup" "git-standup" "$HOME/.local/bin/git-standup" true
github_sync "paulirish/git-open" "git-open" "$HOME/.local/bin/git-open" true
github_sync "paulirish/git-recent" "git-recent" "$HOME/.local/bin/git-recent" true

# vi: ft=sh
