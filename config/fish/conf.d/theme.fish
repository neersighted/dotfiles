status --is-interactive; or exit

# Solarized Dark
set color_base03  \#002b36 brblack
set color_base02  \#073642 black
set color_base01  \#586e75 brgreen
set color_base00  \#657b83 bryellow
set color_base0   \#839496 brblue
set color_base1   \#93a1a1 brcyan
set color_base2   \#eee8d5 white
set color_base3   \#fdf6e3 brwhite
set color_yellow  \#b58900 yellow
set color_orange  \#cb4b16 brred
set color_red     \#dc322f red
set color_magenta \#d33682 magenta
set color_violet  \#6c71c4 brmagenta
set color_blue    \#268bd2 blue
set color_cyan    \#2aa198 cyan
set color_green   \#859900 green

#
# terminal theme
#

set ESC \e
set BEL \a
set ST \e\\

function hex_octets -a color
  string match -ar '[[:xdigit:]]{2}' $color
end

function hex_color -a color
  string replace '#' '' $color
end

function xrdb_color -a color
  printf 'rgb:%s/%s/%s' (hex_octets $color)
end

function term_color -a idx color
  if test $TERM = 'linux'
    printf $ESC']P%x%s' $idx (hex_color $color)
  else if set -q ITERM_SESSION_ID
    printf $ESC']P%x%s'$ST $idx (hex_color $color)
  else
    printf $ESC']4;%i;%s'$ST $idx (xrdb_color $color)
  end
end

function term_special -a idx color
  if test $TERM = 'linux'
    return
  else if set -q ITERM_SESSION_ID
    switch $idx
      case 10; set idx g
      case 11; set idx h
      case 12; set idx l
      case 13; set idx m
      case 17; set idx j
      case 19; set idx k
      case 706; set idx i
      case 708
        set -l octets (hex_octets $color)
        printf $ESC']6;1;bg;red;brightness;%d'$BEL 0x$octets[1]
        printf $ESC']6;1;bg;green;brightness;%d'$BEL 0x$octets[2]
        printf $ESC']6;1;bg;blue;brightness;%d'$BEL 0x$octets[3]
        return
      case \*; return
    end

    printf $ESC']P%s%s'$ST $idx (hex_color $color)
  else
    printf $ESC']%i;%s'$ST $idx (xrdb_color $color)
  end
end

term_color 0 $color_base02  # black
term_color 1 $color_red     # red
term_color 2 $color_green   # green
term_color 3 $color_yellow  # yellow
term_color 4 $color_blue    # blue
term_color 5 $color_magenta # magenta
term_color 6 $color_cyan    # cyan
term_color 7 $color_base2   # white
term_color 8 $color_base03  # bright black
term_color 9 $color_orange  # bright red
term_color 10 $color_base01 # bright green
term_color 11 $color_base00 # bright yellow
term_color 12 $color_base0  # bright blue
term_color 13 $color_violet # bright magenta
term_color 14 $color_base1  # bright cyan
term_color 15 $color_base3  # bright white

term_special 10 $color_base0   # fg
term_special 11 $color_base03  # bg
term_special 12 $color_base0   # cursor bg
term_special 13 $color_base03  # cursor fg
term_special 17 $color_base01  # selction bg
term_special 19 $color_base0   # selction fg
term_special 706 $color_base0  # bold
term_special 708 $color_base03 # chrome

# clean up functions
functions -e hex_octets hex_color xrdb_color term_color term_special

#
# fzf adaptive colors
#

if test "$COLORTERM" = 'truecolor'
  set -x FZF_DEFAULT_OPTS "$FZF_BASE_OPTS --color=fg:#839496,bg:#002b36,hl:#eee8d5,fg+:#839496,bg+:#073642,hl+:#d33682 --color=info:#2aa198,prompt:#839496,pointer:#fdf6e3,marker:#fdf6e3,spinner:#2aa198"
else
  set -x FZF_DEFAULT_OPTS "$FZF_BASE_OPTS --color=fg:12,bg:8,hl:7,fg+:12,bg+:0,hl+:5 --color=info:6,prompt:12,pointer:15,marker:15,spinner:6"
end

#
# fish colorscheme
#

set -q fish_initialized; and exit

# prompt
set -U fish_prompt_pwd_dir_length 3
set -U fish_color_cwd $color_yellow
set -U fish_color_cwd_root $color_red
set -U fish_color_user $color_blue
set -U fish_color_user_root $color_red
set -U fish_color_host $color_magenta
set -U fish_color_venv $color_orange
set -U fish_color_jobs $color_cyan
set -U fish_color_status $color_red

# git prompt
set -U __fish_git_prompt_show_informative_status 1
set -U __fish_git_prompt_describe_style 'contains'

set -U __fish_git_prompt_char_upstream_ahead '>'
set -U __fish_git_prompt_char_upstream_behind '<'
set -U __fish_git_prompt_char_upstream_equal '='
set -U __fish_git_prompt_char_stateseperator '|'

set -U __fish_git_prompt_char_cleanstate '-'
set -U __fish_git_prompt_char_dirtystate '~'
set -U __fish_git_prompt_char_invalidstate '#'
set -U __fish_git_prompt_char_stagedstate '+'
set -U __fish_git_prompt_char_stashstate '$'
set -U __fish_git_prompt_char_untrackedfiles '?'

set -U __fish_git_prompt_color_branch $color_base00
set -U __fish_git_prompt_color_cleanstate $color_green
set -U __fish_git_prompt_color_dirtystate $color_blue
set -U __fish_git_prompt_color_invalidstate $color_red
set -U __fish_git_prompt_color_stagedstate $color_yellow
set -U __fish_git_prompt_color_stashstate $color_cyan
set -U __fish_git_prompt_color_untrackedfiles $color_magenta

# dirh
set -U fish_color_history_current --bold

# pager
set -U fish_pager_color_completion
set -U fish_pager_color_description $color_yellow
set -U fish_pager_color_prefix $color_base2
set -U fish_pager_color_progress $color_base3 --background $color_blue

# syntax highlighting
set -U fish_color_normal $color_base0
set -U fish_color_command $color_base1
set -U fish_color_param $color_base0
set -U fish_color_quote $color_base00
set -U fish_color_operator $color_blue
set -U fish_color_match $color_green
set -U fish_color_escape $color_magenta
set -U fish_color_redirection $color_cyan
set -U fish_color_end $color_yellow
set -U fish_color_error $color_red
set -U fish_color_comment $color_base01
set -U fish_color_autosuggestion $color_base01
set -U fish_color_cancel $color_base01
set -U fish_color_search_match --background $color_base02
set -U fish_color_selection $color_base3 --background $color_cyan
set -U fish_color_valid_path --underline

# manpages
set -U man_color_blink $color_magenta --bold --underline
set -U man_color_bold $color_base2
set -U man_color_standout --reverse
set -U man_color_underline $color_blue --underline
