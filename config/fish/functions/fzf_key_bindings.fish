function fzf_key_bindings --description 'fzf keybindings'
  function __fzf_wrap
    read -l stdin

    test "$stdin" = ''; and return

    eval "$argv $stdin"
  end

  function __fzf_select
    find * \
      -path '*/\.*' \
      -prune \
      -o -type f -print \
      -o -type d -print \
      -o -type l -print \
      ^/dev/null |\
    fzf -m |\
    while read item
      echo -n (echo -n "$item" | sed 's/ /\\\\ /g')' '
    end
  end

  function __fzf_ctrl_t
    function __fzf_tmux_height
      set -l height 40%
      set -q FZF_TMUX_HEIGHT; and set height $FZF_TMUX_HEIGHT

      if echo $height | grep -q -E '%$'
        echo "-p "(echo $height | sed 's/%$//')
      else
        echo "-l $height"
      end
    end

    if test -n "$TMUX_PANE"
      tmux split-window (__fzf_tmux_height) "fish -c 'fzf_key_bindings; __fzf_ctrl_t_tmux \\$TMUX_PANE'"
    else
      __fzf_select |\
      __fzf_wrap commandline -i
    end

    commandline -f repaint
  end

  function __fzf_ctrl_t_tmux
    __fzf_select |\
    __fzf_wrap tmux send-keys -t \\$argv[1]
  end

  function __fzf_ctrl_r
    # populate the command line with history
    history |\
    fzf +s +m | \
    __fzf_wrap commandline

    commandline -f repaint
  end

  function __fzf_alt_c
    # cd to a directory
    find * \
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
