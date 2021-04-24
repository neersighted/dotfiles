function emit_startup --on-event fish_prompt
  emit fish_startup

  functions -e (status current-function)
end
