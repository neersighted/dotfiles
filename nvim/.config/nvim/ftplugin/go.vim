setlocal keywordprg=:GoDoc

nmap <buffer> <leader>g :GoDef<cr>
nmap <buffer> <leader>r :GoRename<cr>

let b:undo_ftplugin = 'setlocal keywordprg< | mapclear <buffer>'
