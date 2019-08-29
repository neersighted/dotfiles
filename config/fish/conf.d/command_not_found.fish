status is-interactive; or exit

if command -sq pkgfile # Arch
  function __fish_command_not_found_handler -a cmd --on-event fish_command_not_found
    if set pkgs (pkgfile -bv -- $cmd)
      printf '%s may be found in the following packages:\n' $cmd
      for pkg in $pkgs
        printf '  %s\n' $pkg
      end
    else
      __fish_default_command_not_found_handler $cmd
    end
  end
else if command -sq brew # macOS
  function __fish_command_not_found_handler -a cmd --on-event fish_command_not_found

    if brew which-formula --explain $cmd | read -z text
        printf '%s' $text
    else
      __fish_default_command_not_found_handler $cmd
    end
  end
end
