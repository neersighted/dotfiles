#!/bin/sh -e

# portsdir=${PORTSDIR:-/usr/ports}
# if [ ! -d "${portsdir}" ]; then
#    echo "The ${portsdir} ports directory does not exist"
#    echo "There is nothing more to do."
#    exit
# fi

PORTSDIR=${PORTSDIR:-/usr/ports}
if [ ! -d "$PORTSDIR" ]; then
  echo "The $PORTSDIR ports directory does not exist"
  echo "There is nothing more to do."
  exit
fi

PORT_DBDIR=${PORT_DBDIR:-$(make -C "$PORTSDIR/lang/gcc" -V PORT_DBDIR 2>/dev/null)}
if [ ! -d "$PORT_DBDIR" ]; then
  echo "The $PORT_DBDIR option database does not exist"
  echo "There is nothing more to do."
  exit
fi

port_origin() {
  basename=$(basename "$1")
  category=$(printf '%s' "$basename" | cut -d_ -f1)
  port=$(printf '%s' "$basename" | cut -d_ -f2)
  printf '%s/%s' "$category" "$port"
}

clean_options() {
  port_dir="$PORTSDIR/$(port_origin "$1")"

  if [ ! -d "$port_dir" ]; then
    printf '%s\n' "$1"
    return
  fi

  selected_pristine=$(make -C "$port_dir" -V SELECTED_OPTIONS PORT_DBDIR=/dev/null)
  selected_now=$(make -C "$port_dir" -V SELECTED_OPTIONS)
  deselected_pristine=$(make -C "$port_dir" -V DESELECTED_OPTIONS PORT_DBDIR=/dev/null)
  deselected_now=$(make -C "$port_dir" -V DESELECTED_OPTIONS)

  if [ "${selected_pristine}" = "${selected_now}" ] && [ "${deselected_pristine}" = "${deselected_now}" ]; then
    printf '%s\n' "$1"
  fi
}

for optdir in "$PORT_DBDIR"/*; do
  test -d "$optdir" && clean_options "$optdir"
done
