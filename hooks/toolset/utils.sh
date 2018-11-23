toolset_subsection "Utils"

# Simple Utilities
cargo_install "bat"
cargo_install "exa"
cargo_install "fd-find"
cargo_install "hyperfine"
cargo_install "ripgrep"
cargo_install "watchexec"

# Code Counters
go_get "github.com/boyter/scc"
cargo_install "tokei"

# Data Processing
go_get "github.com/simeji/jid/cmd/jid"
go_get "mvdan.cc/xurls/cmd/xurls"

# Shell Tools
pipx_install "asciinema"
pipx_install "shell-functools"
