function __fzf_preview_file -a file
  if file --mime-encoding $file | string match -eq 'binary'
    file -z $file
  else
    if command -aq highlight
      highlight -O ansi --line-numbers --force $file
    else if command -sq bat
      bat --style=numbers --color=always $file
    else
      command cat $file
   end
  end
end
