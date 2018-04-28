map f <plug>Sneak_f
map F <plug>Sneak_F
map t <plug>Sneak_t
map T <plug>Sneak_T
nmap <leader>s <Plug>SneakLabel_s
nmap <leader>S <Plug>SneakLabel_S

let g:sneak#f_reset = 1 " Set ; and , when f is used...
let g:sneak#t_reset = 1 " ...same for t.
let g:sneak#absolute_dir = 0 " Use standard ;/, behavior.
