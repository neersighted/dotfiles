# shellcheck shell=sh

toolset_subsection "Unixish"

# Unix-ish tools (default to system versions)
if ! command -v bat >/dev/null; then
  cargo_install "bat"
fi
if ! command -v diskus >/dev/null; then
  cargo_install "diskus"
fi
if ! command -v hexyl >/dev/null; then
  cargo_install "hexyl"
fi
if ! command -v hyperfine >/dev/null; then
  cargo_install "hyperfine"
fi
if ! command -v sd >/dev/null; then
  cargo_install "sd"
fi
if ! command -v tldr >/dev/null; then
  cargo_install "tealdeer"
fi
if ! command -v watchexec >/dev/null; then
  cargo_install "watchexec"
fi

# Pipeline Tools
cargo_install "runiq"
pipx_install "shell-functools"
pipx_install "pygments"

# Parsing/Extraction Tools
cargo_install "xsv"
go_get "mvdan.cc/xurls/cmd/xurls"

# LoC
go_get "github.com/boyter/scc"
if ! command -v tokei >/dev/null; then
  cargo_install "tokei"
fi
