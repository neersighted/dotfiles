status is-interactive; or exit

if command -q pacman # Arch
  function fish_command_not_found_handler --on-event fish_command_not_found -a cmd
    __fish_default_command_not_found_handler $cmd

    if set pkgs (pacman -Fq /usr/bin/$cmd)
      printf '%s may be found in the following packages:\n' $cmd
      for pkg in $pkgs
        printf '  %s\n' $pkg
      end
    end
  end
else if command -q pkg # FreeBSD
  function fish_command_not_found_handler --on-event fish_command_not_found -a cmd
    __fish_default_command_not_found_handler $cmd

    set pkgs (pkg provides local/[s]?bin/$cmd)
    if test -n "$pkgs"
      printf '%s may be found in the following packages:\n' $cmd
      for pkg in $pkgs
        printf '  %s\n' $pkg
      end
    end
  end
else if command -q brew # macOS
  function fish_command_not_found_handler --on-event fish_command_not_found -a cmd
    __fish_default_command_not_found_handler $cmd

    if brew which-formula ---on-eventxplain $cmd | read -z text
        printf '%s' $text
    end
  end
end
