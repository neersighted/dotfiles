function path_dedupe -d "deduplicate PATH (prefers first entry)"
  set PATH (path_list | awk '!seen[$0]++')
end
