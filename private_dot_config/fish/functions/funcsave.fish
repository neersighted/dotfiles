function funcsave -d 'Save the current definition of all specified functions to file'
    set -l options 'd/directory='
    argparse -N 1 $options -- $argv
    or return

    if set -q _flag_directory
        set funcdir $_flag_directory
    else
        set configdir
        set funcdir $__fish_config_dir/functions
    end

    set -l retval 0
    for funcname in $argv
        if functions -q -- $funcname
            functions -- $funcname >$funcdir/$funcname.fish
        else
            printf "%s: Unknown function '%s' \n" (status current-function) $funcname
            set retval 1
        end
    end

    if test "$retval" -eq 0; and set -q configdir
        for funcname in $argv
            chezmoi add $funcdir/$funcname.fish
        end
    end

    return $retval
end
