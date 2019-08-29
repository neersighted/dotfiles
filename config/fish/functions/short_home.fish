function short_home -d 'replace $HOME with ~'
  string replace -r "^$HOME(?=\$|/)" '~' $argv
end
