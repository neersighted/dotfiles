function emit_startup --on-event fish_prompt
  functions -e (status current-function)

  emit fish_startup
end
