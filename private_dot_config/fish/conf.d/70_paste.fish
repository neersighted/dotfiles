status is-interactive; or exit

# wrappers to make fish_clipboard_copy/fish_clipboard_paste work with clipboard-provider
function pbcopy
  clipboard-provider copy
end

function pbpaste
  clipboard-provider paste
end
