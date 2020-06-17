status is-interactive; or exit

# Nord
set nord0  \#2E3440
set nord1  \#3B4252
set nord2  \#434C5E
set nord3  \#4C566A
set nord4  \#D8DEE9
set nord5  \#E5E9F0
set nord6  \#ECEFF4
set nord7  \#8FBCBB
set nord8  \#88C0D0
set nord9  \#81A1C1
set nord10 \#5E81AC
set nord11 \#BF616A
set nord12 \#D08770
set nord13 \#EBCB8B
set nord14 \#A3BE8C
set nord15 \#B48EAD

#
# exa colors
#

set -x EXA_COLORS uu=35:gu=35

#
# fzf colors
#

set -x FZF_DEFAULT_OPTS $FZF_BASE_OPTS \
   --color=fg:$nord5,bg:$nord0,hl:$nord9 \
   --color=fg+:$nord5,bg+:$nord1,hl+:$nord9 \
   --color=info:$nord13,prompt:$nord11,pointer:$nord15 \
   --color=marker:$nord14,spinner:$nord15,header:$nord14

#
# fish colorscheme
#

# syntax highlighting
set -g fish_color_normal $nord4
set -g fish_color_command $nord14
set -g fish_color_param $nord4
set -g fish_color_redirection $nord15
set -g fish_color_comment $nord2
set -g fish_color_error $nord11
set -g fish_color_escape $nord8
set -g fish_color_operator $nord9
set -g fish_color_end $nord3
set -g fish_color_quote $nord4
set -g fish_color_autosuggestion $nord3
set -g fish_color_valid_path --underline
set -g fish_color_match --background $nord9
set -g fish_color_search_match nord13 --background $nord3
set -g fish_color_selection $nord6 --background $nord3
set -g fish_color_cancel -r

# prompt
set -g fish_color_cwd $nord9
set -g fish_color_cwd_root $fish_color_cwd
set -g fish_color_host $nord15
set -g fish_color_host_remote $nord15
set -g fish_color_jobs $nord12
set -g fish_color_status $nord11
set -g fish_color_timer $nord3
set -g fish_color_user $nord10
set -g fish_color_user_root $nord4

# version prompt
set -g prompt_version_color_golang $nord8
set -g prompt_version_color_nodejs $nord14
set -g prompt_version_color_python $nord13
set -g prompt_version_color_python_venv $nord13
set -g prompt_version_color_ruby $nord11
set -g prompt_version_color_rust $nord12

# git prompt
set -g prompt_git_color_branch $nord10
set -g prompt_git_color_detached $nord15
set -g prompt_git_color_upstream $nord9
set -g prompt_git_color_operation $nord12
set -g prompt_git_color_staged $nord14
set -g prompt_git_color_unstaged $nord8
set -g prompt_git_color_unmerged $nord11
set -g prompt_git_color_untracked $nord13
set -g prompt_git_color_stashed $nord10

set -g prompt_git_clean ''

# dirh
set -g fish_color_history_current --bold

# pager
set -g fish_pager_color_prefix $nord3
set -g fish_pager_color_completion $nord4
set -g fish_pager_color_description $nord13
set -g fish_pager_color_progress $nord6 --background $nord10

# manpages
set -g man_color_blink $nord15 --bold --underline
set -g man_color_bold $nord5
set -g man_color_standout --reverse
set -g man_color_underline $nord10 --underline

#
# terminal theme
#

status is-login; or test "$SHLVL" -eq 1; or exit

function hex_octets -a color
  string match -ar '[[:xdigit:]]{2}' $color
end

function hex_color -a color
  string replace '#' '' $color
end

function xrdb_color -a color
  printf 'rgb:%s/%s/%s' (hex_octets $color)
end

set -l ESC \e
set -l BEL \a
set -l ST \e\\

function term_color --inherit-variable ESC --inherit-variable ST -a idx color
  if test $TERM = 'linux'
    printf $ESC']P%x%s' $idx (hex_color $color)
  else if is_iterm
    printf $ESC']P%x%s'$ST $idx (hex_color $color)
  else
    printf $ESC']4;%i;%s'$ST $idx (xrdb_color $color)
  end
end

function term_special --inherit-variable ESC --inherit-variable BEL --inherit-variable ST -a idx color
  if test $TERM = 'linux'
    return
  else if is_iterm
    switch $idx
      case 10; set idx g
      case 11; set idx h
      case 13; set idx m
      case 14; set idx l
      case 17; set idx j
      case 19; set idx k
      case 706; set idx i
      case 708
        set octets (hex_octets $color)
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

term_color 0 $nord1   # black
term_color 1 $nord11  # red
term_color 2 $nord14  # green
term_color 3 $nord13  # yellow
term_color 4 $nord9   # blue
term_color 5 $nord15  # magenta
term_color 6 $nord8   # cyan
term_color 7 $nord5   # white
term_color 8 $nord3   # bright black
term_color 9 $nord11  # bright red
term_color 10 $nord14 # bright green
term_color 11 $nord13 # bright yellow
term_color 12 $nord9  # bright blue
term_color 13 $nord15 # bright magenta
term_color 14 $nord7  # bright cyan
term_color 15 $nord6  # bright white

term_special 10 $nord4  # fg
term_special 11 $nord0  # bg
term_special 12 $nord4  # cursor (auto)
term_special 13 $nord0  # cursor (man) fg
term_special 14 $nord4  # cursor (man) bg
term_special 17 $nord2  # selection bg
term_special 19 $nord4  # selection fg
term_special 706 $nord4 # bold
term_special 708 $nord0 # chrome

# clean up
functions -e hex_octets hex_color xrdb_color term_color term_special
