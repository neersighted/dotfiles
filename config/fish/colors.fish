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

  set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:#839496,bg:#002b36,hl:#eee8d5,fg+:#839496,bg+:#073642,hl+:#d33682 --color=info:#2aa198,prompt:#839496,pointer:#fdf6e3,marker:#fdf6e3,spinner:#2aa198"
else
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

  set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:12,bg:8,hl:7,fg+:12,bg+:0,hl+:5 --color=info:6,prompt:12,pointer:15,marker:15,spinner:6"
end

# syntax highlighting colors
set -g fish_color_normal $color_base0
set -g fish_color_command $color_base1
set -g fish_color_param $color_base0
set -g fish_color_quote $color_base00
set -g fish_color_operator $color_blue
set -g fish_color_match $color_green
set -g fish_color_escape $color_orange
set -g fish_color_redirection $color_violet
set -g fish_color_end $color_yellow
set -g fish_color_error $color_red
set -g fish_color_comment $color_base01
set -g fish_color_autosuggestion $color_base01
set -g fish_color_cancel $color_base01
set -g fish_color_search_match --background=$color_base02
set -g fish_color_selection $color_base3 --background=$color_cyan
set -g fish_color_valid_path --underline

# prompt colors
set -g fish_color_cwd $color_yellow
set -g fish_color_cwd_root $color_orange
set -g fish_color_user $color_base0
set -g fish_color_user_root $color_red
set -g fish_color_host $color_cyan
set -g fish_color_status $color_red

# pager colors
set -g fish_pager_color_completion
set -g fish_pager_color_description $color_yellow
set -g fish_pager_color_prefix $color_base2
set -g fish_pager_color_progress $color_base3 --background=$color_blue

# dirh colors
set -g fish_color_history_current --bold
