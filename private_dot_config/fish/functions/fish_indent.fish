# Defined in /tmp/fish.wIEKuM/fish_indent.fish @ line 1
function fish_indent
  # export color variables for syntax highlighting
  for color in $fish_colors
    set -x $color $$color
  end

  command fish_indent $argv
end
