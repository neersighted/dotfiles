# shellcheck shell=sh

section() {
  printf "\\033[0;33m%s\\033[0m\\n" "$@"
}

subsection() {
  printf "\\033[0;34m%s\\033[0m\\n" "$@"
}


info() {
  printf "\\033[0;32m%s\\033[0m\\n" "$@"
}

important() {
  printf "\\033[0;35m%s\\033[0m\\n" "$@"
}

error() {
  printf "\\033[0;31m%s\\033[0m\\n" "$@"
  exit 1
}
