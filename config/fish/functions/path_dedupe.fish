function path_dedupe -d "deduplicate PATH (prefers first entry)"
  set PATH (echo $PATH | xargs -n1 | awk '!seen[$0]++')
end
