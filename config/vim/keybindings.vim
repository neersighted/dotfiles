"
" Basics
"

if has("gui_macvim")
    " Fix the meta key, thank you.
    set macmeta
endif

" Better leader keys.
let mapleader               = "\\"
let maplocalleader          = "\\"
let g:EasyMotion_leader_key = ';'

" Move over visual lines (wrapped lines).
nnoremap j gj
nnoremap k gk

" Disable bad-practice keys in insert mode.
inoremap <left> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <right> <nop>

"
" Settings/Toggles
"

" Toggle background from light to dark.
silent! call togglebg#map("<leader>c")
" Toggle syntax highlighting.
nnoremap <silent> <leader>s :if exists("g:syntax_on") <bar> syntax off <bar> else <bar> syntax on <bar> endif<cr>
" Toggle automatic indenting.
nnoremap <silent> <leader>i :setlocal autoindent! autoindent?<cr>
" Toggle hidden characters.
nnoremap <silent> <leader>h :setlocal list! list?<cr>
" Toggle line numbers.
nnoremap <silent> <leader>n :setlocal number! relativenumber!<cr>
" Toggle paste mode.
nnoremap <silent> <leader>r :setlocal paste! paste?<cr>
set pastetoggle=<leader>r
" Toggle spell checking.
nnoremap <silent> <leader>z :setlocal spell! spell?<cr>
" Toggle forced line wrapping.
nnoremap <silent> <leader>q :setlocal wrap! wrap?<cr>
" Toggle Hardtime/Hardmode.
nnoremap <silent> <leader>x :HardTimeToggle<cr>
nnoremap <silent> <leader>X :call ToggleHardMode()<cr>

"
" Enhancements/Tweaks
"

" Ag!
nnoremap <silent> <leader>/ :Ag!<space>

" Toggle folds open/closed.
nnoremap <space> za

" Format a line.
nnoremap Q gq
" Split a line (complements J).
nnoremap K i<cr><esc>
" Yank from cursor to end of line (complements yy).
call yankstack#setup() " Yankstack compatibility...
nnoremap Y y$

" Retain selection when indenting in Visual mode (sugar for gv).
vnoremap < <gv
vnoremap > >gv
" Reselect pasted text in Visual mode (sugar for `]).
nnoremap pv V`]
vnoremap p p`]

" Map meta-h/l to switch buffers.
nnoremap <silent> <m-h> :bp<cr>
nnoremap <silent> <m-l> :bn<cr>
" ...and meta-c/meta-shift-c to quit and delete.
nnoremap <silent> <m-c> :Bdelete<cr>
nnoremap <silent> <m-s-c> :q<cr>

" Line bubbling (sugar for ]e/[e).
nmap <m-j> <plug>unimpairedMoveDown
nmap <m-k> <plug>unimpairedMoveUp
vmap <m-j> <plug>unimpairedMoveSelectionDowngv
vmap <m-k> <plug>unimpairedMoveSelectionUpgv

"
" Utilities
"

" Open CtrlP.
nnoremap <silent> <leader>p :CtrlP<cr>
nnoremap <silent> <leader>P :CtrlPMixed<cr>
" Toggle the NERDTree.
nnoremap <silent> <leader>n :NERDTreeToggle<cr>
" Toggle the Tagbar.
nnoremap <silent> <leader>t :TagbarToggle<cr>
" Toggle the Undotree.
nnoremap <silent> <leader>u :UndotreeToggle<cr>

