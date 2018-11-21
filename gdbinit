set history filename ~/.cache/gdb_history

source ~/.local/share/gdb-dashboard/.gdbinit

dashboard -layout assembly registers source expressions stack memory threads history

dashboard -style prompt '\\[\\e[1;35m\\]>>>\\[\\e[0m\\]'
dashboard -style prompt_running '\\[\\e[31m\\]>>>\\[\\e[0m\\]'
dashboard -style prompt_not_running '\\[\\e[1;32m\\]>>>\\[\\e[0m\\]'

dashboard -style style_selected_1 '32'
dashboard -style style_selected_2 '1;34'
dashboard -style style_low '1;32'

dashboard stack -style arguments True
dashboard stack -style locals True
