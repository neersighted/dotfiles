status is-interactive; or exit

# wrappers to make edit_command_buffer/funced play nice with nvim
if not functions -q __edit_command_buffer
  functions -c edit_command_buffer __edit_command_buffer
  function edit_command_buffer
    set -g nvim_wait
    __edit_command_buffer $argv
    set -eg nvim_wait
  end
end

if not functions -q __funced
  functions -c funced __funced
  function funced
    set -g nvim_wait
    __funced $argv
    set -eg nvim_wait
  end
end
