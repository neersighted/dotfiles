function __ls_colors
  if not set -qg LS_COLORS
    set -l config $XDG_CONFIG_HOME/dircolors
    set -l dircolors

    if command -sq dircolors
      set dircolors (dircolors -c $config)
    else if command -sq gdircolors
      set dircolors (gdircolors -c $config)
    end

    if test -n "$dircolors"
      set -gx LS_COLORS (string split ' ' $dircolors)[3]
    end
  end
end
