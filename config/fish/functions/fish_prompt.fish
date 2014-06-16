function fish_prompt
    printf (hostname)
    printf ' '
    printf (set_color $fish_color_cwd)
    printf (prompt_pwd)
    printf (set_color normal)
    printf '> '
end
