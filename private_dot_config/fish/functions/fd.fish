command -q fdfind; or exit

function fd --wraps=fdfind
  command fdfind $argv
end
