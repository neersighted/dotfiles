status is-interactive; or exit

# wrappers to make fish_clipboard_copy/fish_clipboard_paste work with yankee
function pbcopy
  yankee -i
end

function pbpaste
  yankee -o
end
