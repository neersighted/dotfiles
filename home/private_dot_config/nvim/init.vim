scriptencoding utf-8

lua vim.loader.enable() -- Cache compiled Lua modules to disk (~30% speedup on require chains).

"
" Preferences
"

" Backend
set undofile " Persist undo history.
set hidden " Allow backgrounding dirty buffers.

" Colors (real setup happens at the bottom after plugins load).
set termguicolors " Use 24-bit color.

" Cursor/Movement
set scrolloff=2 " Keep the cursor two lines from the top/bottom.
set virtualedit=onemore,block " Allow cursor to the end of the line (and anywhere in visual-block.)
augroup redraw " Redraw aggressively on focus gained/resize.
  autocmd!
  autocmd FocusGained,VimResized * mode
augroup END

" Grep
set grepprg=rg\ -i\ --vimgrep " Use ripgrep.
set grepformat^=%f:%l:%c:%m

" Mouse
set mouse=a " Enable full mouse support.

" Numbering
set number relativenumber " Show (relative) line numbers.
augroup numbertoggle " Toggle 'relativenumber' on insert.
  autocmd!
  autocmd InsertEnter,BufLeave,WinLeave,FocusLost * nested
            \ if &l:number && empty(&buftype) |
            \ setlocal norelativenumber |
            \ endif
  autocmd InsertLeave,BufEnter,WinEnter,FocusGained * nested
              \ if &l:number && mode() != 'i' && empty(&buftype) |
              \ setlocal relativenumber |
              \ endif
augroup END

" Remote Plugins
let g:loaded_node_provider = 0 " Disable Node.js.
let g:loaded_perl_provider = 0 " Disable Perl.
let g:loaded_python3_provider = 0 " Disable Python 3.
let g:loaded_python_provider = 0 " Disable Python 2.
let g:loaded_ruby_provider = 0 " Disable Ruby.

" Search
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.
noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 50)| " Center/blink after search.

" Status
set noshowmode showtabline=2 " Hide mode, always show tabline.

" Splits
set splitright splitbelow " Open vertical splits to the right, horizontal below.

" Substitution
set inccommand=split " Show incomplete substitutions in a preview split.

" Syntax

" Terminal
set title titlestring=nvim\ %t%(\ %m%r%)\ (%{fnamemodify(getcwd(),':~')})

" Whitespace
set list listchars=tab:→·,nbsp:·,trail:~,extends:»,precedes:« " Show hidden characters.
set showbreak=>\  " Show a character for wrapped lines.

" Wrapping
set colorcolumn=+1 " Show the wrapping column visually.
set linebreak breakindent " Enable visual line wrapping.

" Yank
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.hl.on_yank()
augroup END

" Other
let g:loaded_2html_plugin = 1 " Disable :TOhtml.
let g:loaded_matchit = 1 " Disable matchit (replaced by vim-matchup).
let g:loaded_matchparen = 1 " Disable matchparen (replaced by vim-matchup).
let g:loaded_netrwPlugin = 1 " Disable Netrw (replaced by dirvish).
let g:loaded_tarPlugin = 1 " Disable in-nvim .tar file handling.
let g:loaded_tohtml = 1 " Disable :TOhtml (alt name).
let g:loaded_tutor = 1 " Disable :Tutor.
let g:loaded_zipPlugin = 1 " Disable in-nvim .zip file handling.
let g:startuptime_self = 1 " Use 'self' time when profiling.

"
" Maps/Abbreviations
"

let g:mapleader = ' '
let g:maplocalleader = '\\'

" fzf
nnoremap <leader><leader> :Buffers<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>' :Marks<cr>
nnoremap <leader>/ :BLines<cr>
nnoremap <leader><c-/> :Lines<cr>
nnoremap <leader>r :Rg<cr>
nnoremap <leader><c-r> :Ggrep<cr>
nnoremap <leader>t :BTags<cr>
nnoremap <leader><c-t> :Tags<cr>

nmap <leader>? <plug>(fzf-maps-n)
omap <leader>? <plug>(fzf-maps-o)
xmap <leader>? <plug>(fzf-maps-x)

" Sidebars
nnoremap <silent> <leader>u <cmd>lua require('undotree').toggle()<cr>
nnoremap <leader>y :Vista!!<cr>

" Align text using EasyAlign.
nmap gl   <plug>(EasyAlign)
xmap gl   <plug>(EasyAlign)
vmap <cr> <plug>(EasyAlign)

" Move arguments/list items around.
nnoremap ]v :SidewaysRight<cr>
nnoremap [v :SidewaysLeft<cr>

" Keep indent selection in visual mode.
vnoremap < <gv
vnoremap > >gv

" Simple buffer/window management.
nnoremap <leader>x :Sayonara<cr>
nnoremap <leader>d :Sayonara!<cr>
cnoreabbrev wq w<bar>Sayonara
cnoreabbrev  q       Sayonara

" Simple resizing.

" Make <c-e>/<c-y> faster.
nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

" Toggle loclist/quickfix.
function! s:qftoggle(loc) abort
  let l:key = a:loc ? 'loclist' : 'quickfix'
  let l:open = !empty(filter(getwininfo(), 'v:val[l:key] == 1'))
  execute (l:open ? (a:loc ? 'lclose' : 'cclose') : (a:loc ? 'lopen' : 'copen'))
endfunction
nnoremap <leader>q :call <SID>qftoggle(1)<cr>
nnoremap <leader>Q :call <SID>qftoggle(0)<cr>

" Ergonomic :terminal escape.
tnoremap <esc> <c-\><c-n>
tnoremap <a-[> <esc>

"
" Colors
"

" Plugin load needs to happen before :colorscheme
lua require('pack')

" Eager load colorscheme, but defer customization to load less at startup.
colorscheme nord
lua <<EOF
vim.schedule(function()
  require('nord').setup({
    borders = true,
    on_highlights = function(hl, c)
      hl.NormalFloat = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
      hl.NormalNC    = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
      hl.Pmenu       = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
      hl.SignColumn  = { bg = c.polar_night.bright }
    end,
  })
  vim.cmd.colorscheme('nord')
end)
EOF
