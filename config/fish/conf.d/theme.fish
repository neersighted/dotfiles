if not set -q fish_initialized
  source $XDG_CONFIG_HOME/fish/solarized.fish

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
  set -U fish_pager_color_progress $color_base3 --background=$color_blue

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
  set -U fish_color_search_match --background=$color_base02
  set -U fish_color_selection $color_base3 --background=$color_cyan
  set -U fish_color_valid_path --underline
end
