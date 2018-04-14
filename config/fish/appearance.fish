# shut up
set fish_greeting

# prompt
set -g fish_prompt_pwd_dir_length 3
set -g fish_color_cwd $color_yellow
set -g fish_color_cwd_root $color_red
set -g fish_color_user $color_blue
set -g fish_color_user_root $color_red
set -g fish_color_host $color_cyan
set -g fish_color_jobs $color_orange
set -g fish_color_status $color_red

# git prompt
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_describe_style 'contains'

set -g __fish_git_prompt_char_upstream_ahead '>'
set -g __fish_git_prompt_char_upstream_behind '<'
set -g __fish_git_prompt_char_upstream_equal '='
set -g __fish_git_prompt_char_stateseperator '|'

set -g __fish_git_prompt_char_cleanstate "-"
set -g __fish_git_prompt_char_dirtystate '~'
set -g __fish_git_prompt_char_invalidstate '#'
set -g __fish_git_prompt_char_stagedstate '+'
set -g __fish_git_prompt_char_stashstate '$'
set -g __fish_git_prompt_char_untrackedfiles '?'

set -g __fish_git_prompt_color_branch $color_base00
set -g __fish_git_prompt_color_cleanstate $color_green
set -g __fish_git_prompt_color_dirtystate $color_blue
set -g __fish_git_prompt_color_invalidstate $color_red
set -g __fish_git_prompt_color_stagedstate $color_yellow
set -g __fish_git_prompt_color_stashstate $color_orange
set -g __fish_git_prompt_color_untrackedfiles $color_base2

# fzf
set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:$color_base0,bg:$color_base03,hl:$color_base2,fg+:$color_base0,bg+:$color_base02,hl+:$color_magenta --color=info:$color_cyan,prompt:$color_base0,pointer:$color_base3,marker:$color_base3,spinner:$color_cyan"
# set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:12,bg:8,hl:7,fg+:12,bg+:0,hl+:5 --color=info:6,prompt:12,pointer:15,marker:15,spinner:6"

# dirh
set -g fish_color_history_current --bold

# pager
set -g fish_pager_color_completion
set -g fish_pager_color_description $color_yellow
set -g fish_pager_color_prefix $color_base2
set -g fish_pager_color_progress $color_base3 --background=$color_blue

# syntax highlighting
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
