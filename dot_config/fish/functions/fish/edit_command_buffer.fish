function edit_command_buffer -d 'edit the command buffer in an external editor'
  set -l otmp (mktemp)
  set -l tmp $otmp.fish
  mv $otmp $tmp

  commandline -b >$tmp
  __fish_disable_bracketed_paste
  $FISH_EDITOR $tmp
  set -l editor_status $status
  __fish_enable_bracketed_paste

  if test $editor_status -eq 0; and test -s $tmp
    commandline -r -- (cat $tmp)
    commandline -C 999999
  end

  commandline -f repaint
  command rm $tmp
end
