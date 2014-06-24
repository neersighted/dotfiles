function fzf_key_bindings --description 'create fzf keybindings'
  function __fzf_wrap --description 'wrap stdin as an argument to a command'
    read -l stdin

    test -n "$stdin"; or return

    set stdin (echo $stdin | sed "s/\"/\\\\\"/g")
    eval "$argv \"$stdin\""
  end

  function __fzf_select --description 'select a tree with fzf'
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

  function __fzf_ctrl_t --description 'insert __fzf_select into the commandline'
    function __fzf_tmux_height --description 'determine a good tmux split size'
      set -l height 40%
      set -q FZF_TMUX_HEIGHT; and set height $FZF_TMUX_HEIGHT

      if echo $height | grep -q -E '%$'
        set height (echo $height | sed 's/%$//')
        echo -n "-p $height"
      else
        echo -n "-l $height"
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

  function __fzf_ctrl_t_tmux --description 'callback in tmux split'
    __fzf_select |\
    __fzf_wrap tmux send-keys -t \\$argv[1]
  end

  function __fzf_ctrl_r --description 'set the commandline to shell history'
    history |\
    fzf +s +m |\
    __fzf_wrap commandline

    commandline -f repaint
  end

  function __fzf_alt_c --description 'cd to a directory'
    command find * \
      -path '*/\.*' \
      -prune \
      -o \
      -type d -print \
      ^/dev/null |\
    fzf +m |\
    __fzf_wrap cd

    commandline -f repaint
  end

  bind \ct '__fzf_ctrl_t'
  bind \cr '__fzf_ctrl_r'
  bind \ec '__fzf_alt_c'
end
