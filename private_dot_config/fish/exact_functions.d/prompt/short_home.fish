function short_home -d 'replace $HOME with ~'
  string replace -r '^'"$HOME"'($|/)' '~$1' $argv
end
