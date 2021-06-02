function tgdb -d 'tmux-enabled gdb(-dashboard)'
  if set -qx TGDB_INNER
    set inferior_tty (tmux split-window -d -PF '#{pane_tty}' -bh -- 'exec disowntty')
    set dashboard_tty (tmux split-window -d -PF '#{pane_tty}' -bv -l 66% -t '{right}' -- 'exec disowntty')
    set source_tty (tmux split-window -d -PF '#{pane_tty}' -bv -l 66% -t '{left}' -- 'exec disowntty')
    set assembly_tty (tmux split-window -d -PF '#{pane_tty}' -bv -t '{top-left}' -- 'exec disowntty')

    function __tgdb_rust
      command -q rustc; or return

      # use rustc to locate the rustlib folder for the current toolchain
      set rustlib (rustc --print=sysroot)/lib/rustlib
      set src_path $rustlib/src/rust
      set load_path $rustlib/etc

      # add load_path to PYTHONPATH so import works
      set -lx -p PYTHONPATH $load_path
      string join -- \n \
         -directory $src_path \
         -ex "add-auto-load-safe-path $load_path"
    end

    function __tgdb_python
      command -q pyenv; or return

      # use pyenv to locate the pythonX-gdb.py file
      # python-build installs it next to the python binaries
      set load_path (dirname (pyenv which python))

      string join -- \n \
         -ex "add-auto-load-safe-path $load_path"
    end

    # run these before gdb so they can mutate the env
    set rust_args (__tgdb_rust)
    set python_args (__tgdb_python)

    # use the tgdb-specific inputrc
    set -x INPUTRC $XDG_CONFIG_HOME/tgdb/inputrc

    gdb -tty $inferior_tty \
       -x $XDG_CONFIG_HOME/tgdb/gdbinit \
       $rust_args \
       $python_args \
       -ex "dashboard -output $dashboard_tty" \
       -ex "dashboard source -output $source_tty" \
       -ex "dashboard assembly -output $assembly_tty" \
       -ex 'start' -quiet $argv

    # mop up 'disowntty' instances
    for pid in (tmux list-panes -F '#{pane_pid}' -f "#{!=:#{pane_pid},$fish_pid}")
      kill $pid
    end

    # and kill all the panes to be sure
    tmux kill-pane -a -t $TMUX_PANE
  else
    is_tmux; and set cmd new-window; or set cmd new-session
    tmux $cmd -n tgdb -e TGDB_INNER=1 -- tgdb $argv
  end
end
