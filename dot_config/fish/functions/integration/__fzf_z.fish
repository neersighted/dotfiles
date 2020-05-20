function __fzf_z -d 'select a directory to jump to using z'
  cd (z -l | string replace -r '^[0-9\.]+\s+' '' | fzf)
end
