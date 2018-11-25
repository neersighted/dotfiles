# shellcheck shell=sh

getshell() {
  case $(uname) in
    Darwin)
      dscacheutil -q user -a name "$USER" | awk '/shell:/{print $2}'
      ;;
    *)
      getent passwd "$USER" | awk -F: '{print $NF}'
      ;;
  esac
}

selectversion() {
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

stem() {
  basename=${1##*/}
  echo "${basename%%.*}"
}
