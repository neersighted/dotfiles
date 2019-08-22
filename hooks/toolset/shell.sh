# shellcheck shell=sh

toolset_subsection "Shell"

# Pipeline Tools
cargo_install "runiq"
pipx_install "shell-functools"
go_get "mvdan.cc/xurls/cmd/xurls"

# Misc
go_get "github.com/boyter/scc"
