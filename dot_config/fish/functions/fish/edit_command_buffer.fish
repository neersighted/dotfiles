if not functions -q __edit_command_buffer_orig
  functions -c edit_command_buffer __edit_command_buffer_orig
end

function edit_command_buffer -d 'edit the command buffer in an external editor'
  set -l old_editor $VISUAL
  set -g VISUAL $fish_editor
  __edit_command_buffer_orig
  set -g VISUAL $old_editor
end
