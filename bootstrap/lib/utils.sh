# shellcheck shell=sh

getshell() { # shell
  case $(uname) in
    Darwin)
      dscl . read "/Users/$USER" UserShell | awk '{print $2}'
      ;;
    *)
      getent passwd "$USER" | awk -F: '{print $7}'
      ;;
  esac
}

setshell() { # shell
  case $(uname) in
    Darwin)
      sudo dscl . create "/Users/$USER" UserShell "$1"
      ;;
    FreeBSD)
      su root -c "pw usermod -n '$USER' -s '$1'"
      ;;
    *)
      sudo usermod -s "$1" "$USER"
      ;;
  esac
}

selectversion() { # major, minor, patch
  awk -v major="$1" -v minor="$2" -v patch="$3" -F '.' '
    /^[ \t]*[0-9]+\.[0-9]+\.[0-9]+[ \t]*$/ {
      if ((major != "" && major != $1) ||
          (minor != "" && minor != $2) ||
          (patch != "" && patch != $3))
      {
        next
      }

      current = ($1 * 100 + $2) * 100 + $3
      if (current > max) {
        max = current
        chosen = $0
      }
    }
    END {
      gsub(/^[ \t]+/, "", chosen)
      gsub(/[ \t]+$/, "", chosen)
      print chosen
    }'
}

stem() { # path
  basename=${1##*/}
  echo "${basename%%.*}"
}
