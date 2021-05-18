# shellcheck shell=sh

{{ $root := default (".") . }}

xenv_ext() { # root
  if ! make -C "{{ $root }}/src" -q; then
    echo "Building native extensions..."
    (
      cd "{{ $root }}" || exit 1
      ./src/configure
    )
    make -C "{{ $root }}/src"
  fi
}
