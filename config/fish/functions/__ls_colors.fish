function __ls_colors
  if not set -q LS_COLORS
    if command -sq dircolors
      dircolors -c $XDG_CONFIG_HOME/dircolors | source
    else if command -sq gdircolors
      gdircolors -c $XDG_CONFIG_HOME/dircolors | source
    else
      set -gx LS_COLORS
    end
  end
end
