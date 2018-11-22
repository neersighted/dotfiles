function __ls_colors
  if not set -qg LS_COLORS
    if command -sq dircolors
      source (dircolors -c $XDG_CONFIG_HOME/dircolors | psub)
    else if command -sq gdircolors
      source (gdircolors -c $XDG_CONFIG_HOME/dircolors | psub)
    else
      set -gx LS_COLORS
    end
  end
end
