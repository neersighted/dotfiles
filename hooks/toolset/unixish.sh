# shellcheck shell=sh

toolset_subsection "Unixish"

# Replacement Tools
cargo_install "bat"
cargo_install "exa"
cargo_install "fd-find"
cargo_install "diskus"
cargo_install "hexyl"
cargo_install "hyperfine"
cargo_install "ripgrep"
cargo_install "runiq"
cargo_install "tealdeer"
cargo_install "tin-summer"
cargo_install "watchexec"

# Pipeline Tools
pipx_install "shell-functools"
pipx_install "pygments"

# Parsing/Extraction Tools
go_get "github.com/simeji/jid/cmd/jid"
cargo_install "xsv"
go_get "mvdan.cc/xurls/cmd/xurls"
