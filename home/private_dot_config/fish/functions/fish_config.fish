# The global config.fish runs `fish_config theme choose default --no-override`
# for every interactive shell. This is unnecessary for us, as we do our own
# theming. We no-op that invocation, and load the real fish_config if otherwise
# invoked.
#
# This file must live in `functions` as we cannot run any code before global
# config.fish; we must rely on shadowing the autoload mechanism.
function fish_config --description "Launch fish's web based configuration"
    if test "$argv" = 'theme choose default --no-override'
        return 0
    end

    source $__fish_data_dir/functions/fish_config.fish
    fish_config $argv
end
