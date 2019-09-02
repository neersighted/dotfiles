# shellcheck shell=sh

toolset_subsection "GDB"

pipx_install "gdbgui"

info "Syncing gdb-dashboard..."
git_sync https://github.com/cyrus-and/gdb-dashboard "$XDG_DATA_HOME/gdb-dashboard"
