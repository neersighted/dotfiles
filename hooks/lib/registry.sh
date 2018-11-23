support_subsection() {
  subsection "$1"
  SUPPORTED="${SUPPORTED:+$SUPPORTED\n}$1"
}

has_support() {
  echo "$SUPPORTED" | grep -Fq "$1"
}

toolset_subsection() {
  subsection "$1"
  TOOLSETS="${TOOLSETS:+$TOOLSETS\n}$1"
}

has_toolset() {
  echo "$TOOLSETS" | grep -Fq "$1"
}
