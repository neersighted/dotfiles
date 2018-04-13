if set -q fish_term24bit
  set -g __color_base03  002b36
  set -g __color_base02  073642
  set -g __color_base01  586e75
  set -g __color_base00  657b83
  set -g __color_base0   839496
  set -g __color_base1   93a1a1
  set -g __color_base2   eee8d5
  set -g __color_base3   fdf6e3
  set -g __color_yellow  b58900
  set -g __color_orange  cb4b16
  set -g __color_red     dc322f
  set -g __color_magenta d33682
  set -g __color_violet  6c71c4
  set -g __color_blue    268bd2
  set -g __color_cyan    2aa198
  set -g __color_green   859900

  set -x FZF_DEFAULT_OPTS '$FZF_DEFAULT_OPTS --color=fg:#839496,bg:#002b36,hl:#eee8d5,fg+:#839496,bg+:#073642,hl+:#d33682 --color=info:#2aa198,prompt:#839496,pointer:#fdf6e3,marker:#fdf6e3,spinner:#2aa198'
else
  set -g __color_base03 --bold black
  set -g __color_base02 black
  set -g __color_base01 --bold green
  set -g __color_base00 --bold yellow
  set -g __color_base0 --bold blue
  set -g __color_base1 --bold cyan
  set -g __color_base2 white
  set -g __color_base3 --bold white
  set -g __color_yellow yellow
  set -g __color_orange --bold red
  set -g __color_red red
  set -g __color_magenta magenta
  set -g __color_violet --bold magenta
  set -g __color_blue blue
  set -g __color_cyan cyan
  set -g __color_green green

  set -x FZF_DEFAULT_OPTS '$FZF_DEFAULT_OPTS --color=fg:12,bg:8,hl:7,fg+:12,bg+:0,hl+:5 --color=info:6,prompt:12,pointer:15,marker:15,spinner:6'
end

set -g fish_color_normal $__color_base0
set -g fish_color_command $__color_base0
set -g fish_color_quote $__color_cyan
set -g fish_color_redirection $__color_base0
set -g fish_color_end $__color_base0
set -g fish_color_error $__color_red
set -g fish_color_param $__color_blue
set -g fish_color_comment $__color_base01
set -g fish_color_match $__color_cyan
set -g fish_color_search_match "--background=$__color_base02"
set -g fish_color_operator $__color_orange
set -g fish_color_escape $__color_cyan

set -g fish_color_user $__color_base0
set -g fish_color_root $__color_red
set -g fish_color_hostname $__color_cyan
set -g fish_color_cwd $__color_yellow
set -g fish_color_venv $__color_orange
set -g fish_color_git $__color_green
