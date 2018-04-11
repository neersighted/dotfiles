function path_dedupe -d "deduplicate PATH (prefers first entry)"
  set PATH (sh -c 'echo $PATH' | tr ':' '\n' | awk '!seen[$0]++')
end
