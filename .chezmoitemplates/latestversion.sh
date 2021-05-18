awk '
  BEGIN {
    FS = "."
    OFS = "."
  }
  /^[ \t]*v?[0-9]+\.[0-9]+\.[0-9]+[ \t]*$/ {
    if ($1 ~ /^v/) {
      $1 = substr($1, 2)
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
