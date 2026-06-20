status is-interactive; or exit


function fish_clipboard_copy
  set -lx COPY_PROVIDERS desktop tmux
  if isatty stdin
    set -l cmdline (commandline --current-selection | fish_indent --only-indent | string collect)
    test -n "$cmdline"; or set cmdline (commandline | fish_indent --only-indent | string collect)
    printf '%s' $cmdline | clipboard-provider copy
  else
    clipboard-provider copy
  end
end

function fish_clipboard_paste
  set -lx PASTE_PROVIDERS desktop tmux
  set -l data (clipboard-provider paste | string collect -N)
  string length -q -- "$data"; or return 1
  if isatty stdout
    __fish_paste $data
  else
    printf '%s' $data
  end
end
