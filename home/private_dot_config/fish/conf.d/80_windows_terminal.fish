is_wt; or exit

function __wt_report_path --on-event fish_prompt
  printf '\e]9;9;%s\e\\' (wslpath -w $PWD)
end
