status is-interactive; or exit

# wrappers to make fish_clipboard_copy/fish_clipboard_paste work with clipboard-provider
function pbcopy
  set -lx COPY_PROVIDERS desktop tmux
  clipboard-provider copy
end

function pbpaste
  set -lx PASTE_PROVIDERS desktop tmux
  clipboard-provider paste
end
