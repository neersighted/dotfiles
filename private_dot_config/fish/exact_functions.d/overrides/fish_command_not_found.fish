if test -x /usr/lib/command-not-found # Generic
  function fish_command_not_found -a cmd
    /usr/lib/command-not-found -- $cmd
  end
else if command -q pacman # Arch
  function fish_command_not_found -a cmd
    __fish_default_command_not_found_handler $cmd

    if set pkgs (pacman -Fq /usr/bin/$cmd)
      printf '%s may be found in the following packages:\n' $cmd
      for pkg in $pkgs
        printf '  %s\n' $pkg
      end
    end
  end
else if command -q pkg # FreeBSD
  function fish_command_not_found -a cmd
    __fish_default_command_not_found_handler $cmd

    set pkgs (pkg provides "local/[s]?bin/$cmd\$")
    if test -n "$pkgs"
      printf '%s may be found in the following packages:\n' $cmd
      for pkg in $pkgs
        printf '  %s\n' $pkg
      end
    end
  end
else if command -q brew # macOS
  function fish_command_not_found -a cmd
    __fish_default_command_not_found_handler $cmd

    if brew which-formula --explain $cmd | read -z text
        printf '%s' $text
    end
  end
end
