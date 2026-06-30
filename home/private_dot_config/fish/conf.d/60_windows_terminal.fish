status is-interactive; and is_wt; or exit

# report PWD via OSC 9;9 to Windows Terminal
# this overrides the built-in OSC 7 support; OSC 133 is implemented in native code
function __fish_update_cwd_osc --on-event fish_prompt --on-variable PWD
  printf '\e]9;9;%s\e\\' (wslpath -w $PWD)
end
