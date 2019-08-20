# shellcheck shell=sh

toolset_subsection "Shell"

# Pipeline Tools
cargo_install "runiq"
pipx_install "shell-functools"

# Parsing/Extraction Tools
cargo_install "xsv"
go_get "mvdan.cc/xurls/cmd/xurls"
