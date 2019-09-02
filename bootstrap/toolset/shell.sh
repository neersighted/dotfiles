# shellcheck shell=sh

toolset_subsection "Shell"

# Shell Editing
go_get "mvdan.cc/sh/cmd/shfmt"

# Pipeline Tools
cargo_install "runiq"
pipx_install "shell-functools"
go_get "mvdan.cc/xurls/cmd/xurls@latest"

# Misc
go_get "github.com/boyter/scc@latest"
