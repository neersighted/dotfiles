function fzf_key_bindings --description 'create fzf keybindings'
  function __fzf_wrap
    # add (the fist line of) stdin as a argument to a command
    read -l stdin

    test "$stdin" = ''; and return

    eval "$argv $stdin"
  end

  function __fzf_select # select files, directories, and symlinks with fzf
    command find * \
      -path '*/\.*' \
      -prune \
      -o -type f -print \
      -o -type d -print \
      -o -type l -print \
      ^/dev/null |\
    fzf -m |\
    while read item
      echo -n (echo $item | sed 's/ /\\\\ /g')
    end
  end

  function __fzf_ctrl_t # insert __fzf_select into the commandline
    function __fzf_tmux_height # determine a height for tmux splits
      set -l height 40%
      set -q FZF_TMUX_HEIGHT; and set height $FZF_TMUX_HEIGHT

      if echo $height | grep -q -E '%$'
        set height (echo $height | sed 's/%$//')
        echo -n "-p $height"
      else
        echo -n "-l $height"
      end
    end

    if test -n "$TMUX_PANE" # if in tmux, open in a split
      tmux split-window (__fzf_tmux_height) "fish -c 'fzf_key_bindings; __fzf_ctrl_t_tmux \\$TMUX_PANE'"
    else
      __fzf_select |\
      __fzf_wrap commandline -i
    end

    commandline -f repaint
  end

  function __fzf_ctrl_t_tmux # call this in tmux, send fzf's output back
    __fzf_select |\
    __fzf_wrap tmux send-keys -t \\$argv[1]
  end

  function __fzf_ctrl_r # populate the command line with history
    history |\
    fzf +s +m | \
    __fzf_wrap commandline

    commandline -f repaint
  end

  function __fzf_alt_c # cd to a directory
    command find * \
      -path '*/\.*' \
      -prune \
      -o \
      -type d \
      -print \
      ^/dev/null |\
    fzf +m |\
    __fzf_wrap cd

    commandline -f repaint
  end

  bind \ct '__fzf_ctrl_t'
  bind \cr '__fzf_ctrl_r'
  bind \ec '__fzf_alt_c'
end
