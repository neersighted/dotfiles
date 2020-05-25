function prompt_pwd
    set -q prompt_pwd_threshold; or set prompt_pwd_threshold 60
    set -q prompt_pwd_dir_length; or set prompt_pwd_dir_length 3
    set -q prompt_pwd_anchors; or set prompt_pwd_anchors .bzr .citc .git .hg .node-version .python-version .go-version .ruby-version .lua-version .java-version .perl-version .php-version .tool-version .shorten_folder_marker .svn .terraform CVS Cargo.toml composer.json go.mod package.json stack.yaml

    set cwd (short_home $PWD)
    if test $prompt_pwd_dir_length -eq 0; or test (string length $cwd) -le $prompt_pwd_threshold
        printf '%s' $cwd
    else
        string replace -ar '(\.?[^/]{'"$prompt_pwd_dir_length"'})[^/]*/' '$1/' $cwd
    end
end
