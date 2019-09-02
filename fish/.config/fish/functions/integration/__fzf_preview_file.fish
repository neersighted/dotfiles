function __fzf_preview_file -a file
  if file --mime-encoding $file | string match -eq 'binary'
    file -z $file
  else
     highlight -O ansi --line-numbers --force $file
     or bat --style=numbers --color=always $file
     or command cat $file
  end
end
