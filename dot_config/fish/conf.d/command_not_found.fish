status is-interactive; or exit

if command -q pacman # Arch
  function __fish_command_not_found_handler -a cmd -e fish_command_not_found
    __fish_default_command_not_found_handler $cmd

    if set pkgs (pacman -Fq /usr/bin/$cmd)
      printf '%s may be found in the following packages:\n' $cmd
      for pkg in $pkgs
        printf '  %s\n' $pkg
      end
    end
  end
else if command -q brew # macOS
  function __fish_command_not_found_handler -a cmd -e fish_command_not_found
    __fish_default_command_not_found_handler $cmd

    if brew which-formula --explain $cmd | read -z text
        printf '%s' $text
    end
  end
end
