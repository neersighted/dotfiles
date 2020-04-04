function path_dedupe -d 'deduplicate PATH (prefers first entry)' -a target
  string match -eq PATH $target; and set -e argv[1]; or set -l target PATH
  set $target (string escape $$target | awk '!seen[$0]++')
end
