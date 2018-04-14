# enable 24bit color
set -g fish_term24bit 1

if set -q fish_term24bit
  set -g color_base03  '#002b36'
  set -g color_base02  '#073642'
  set -g color_base01  '#586e75'
  set -g color_base00  '#657b83'
  set -g color_base0   '#839496'
  set -g color_base1   '#93a1a1'
  set -g color_base2   '#eee8d5'
  set -g color_base3   '#fdf6e3'
  set -g color_yellow  '#b58900'
  set -g color_orange  '#cb4b16'
  set -g color_red     '#dc322f'
  set -g color_magenta '#d33682'
  set -g color_violet  '#6c71c4'
  set -g color_blue    '#268bd2'
  set -g color_cyan    '#2aa198'
  set -g color_green   '#859900'
else
  # currently unused, but here for backwards compat
  set -g color_base03  brblack
  set -g color_base02  black
  set -g color_base01  brgreen
  set -g color_base00  bryellow
  set -g color_base0   brblue
  set -g color_base1   brcyan
  set -g color_base2   white
  set -g color_base3   brwhite
  set -g color_yellow  yellow
  set -g color_orange  brred
  set -g color_red     red
  set -g color_magenta magenta
  set -g color_violet  brmagenta
  set -g color_blue    blue
  set -g color_cyan    cyan
  set -g color_green   green
end
