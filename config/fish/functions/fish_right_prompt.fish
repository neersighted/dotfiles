function fish_right_prompt --description 'right prompt'
  set -l last_status $status

  if set -q minimal; return; end

  set_color normal

  set_color $fish_color_cwd
  printf ' %s' (prompt_pwd)

  set_color normal
  printf '%s' (__fish_git_prompt)

  if not test $last_status -eq 0
    set_color $fish_color_error
    printf ' [%i]' $last_status
  end

  set_color normal
end

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream 'informative'
set -g __fish_git_prompt_char_upstream_ahead '↑'
set -g __fish_git_prompt_char_upstream_behind '↓'
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_conflictedstate 'x'
set -g __fish_git_prompt_char_dirtystate '~'
set -g __fish_git_prompt_char_untrackedfiles '?'
set -g __fish_git_prompt_char_stagedstate '+'
set -g __fish_git_prompt_char_cleanstate "o"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles normal
set -g __fish_git_prompt_color_cleanstate green
