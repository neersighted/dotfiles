# Ugly hack to no-op the first `fish_config theme choose default` that the built-in
# configuration implicitly calls. This should be otherwise transparent.
function fish_config
    return 0
end

function __restore_fish_config --on-event fish_startup
    functions -e (status current-function)
    status get-file functions/fish_config.fish | source
end
