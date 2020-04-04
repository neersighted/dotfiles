if is_freebsd
  function findport -a q
    test -n "$q"; or set -l q .
    fd --fixed-strings --full-path --type directory --max-depth 2 $q /usr/ports \
      | sd '/usr/ports/' '' \
      | grep $q
  end
end

