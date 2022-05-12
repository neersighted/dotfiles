function sha256
  if command -q sha256
    command sha256 -q $argv
  else if command -q sha256sum
    sha256sum $argv | string split -f1 "  "
  else if command -q shasum
    shasum -a 256 $argv | string split -f1 "  "
  else
    echo "No sha256 available?"
    return 1
  end
end
