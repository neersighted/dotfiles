command! -bang -nargs=* Rg call FzfRg(<q-args>, <bang>0)
command! -bang -nargs=* Ggrep call FzfGgrep(<q-args>, <bang>0)
