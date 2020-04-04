function prompt_pwd
    set -q fish_prompt_pwd_threshold; or set -l fish_prompt_pwd_threshold 40
    set -q fish_prompt_pwd_dir_length; or set -l fish_prompt_pwd_dir_length 1

    set cwd (short_home $PWD)
    if test $fish_prompt_pwd_dir_length -eq 0; or test (string length $cwd) -le $fish_prompt_pwd_threshold
        echo $cwd
    else
        string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' $cwd
    end
end
