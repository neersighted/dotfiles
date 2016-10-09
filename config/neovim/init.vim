augroup vimrc
autocmd!

set hidden " Allow backgrounding buffers.

runtime plugs.vim
runtime ui.vim
runtime cmd.vim
runtime maps.vim

" Interface
set number relativenumber " Use relative line numbering.
set colorcolumn=80 " Indicate column 80.
set wrap linebreak wrapmargin=0 " Enable virtual wrapping.
set showbreak=⇇ breakindent " Indicate wrapping with an icon and indent.
set winminheight=0 splitright " Allow squishing splits, open splits to the right.
set list listchars=tab:»·,trail:·,eol:¬,nbsp:_ " Show hidden characters.
set conceallevel=2 concealcursor=nc " Enable conceal support.
set showmatch " Jump when a matched delimiter pair is created.

" Selection

" Editing
set textwidth=0 " Disable automatic wrapping...
autocmd FileType text,gitcommit,markdown setlocal textwidth=78 " ...except some filetypes.
set virtualedit=block,onemore " Allow the cursor to select the end of the line/form blocks.
set whichwrap=h,l,<,>,[,],b,s " Wrap the cursor over line.
set nospell spelllang=en " Disable spell checking by default.
autocmd FileType text,gitcommit,markdown setlocal spell " ...but start it on some filetypes.
set ignorecase smartcase " Ignore case when searching, unless a uppercase letter is present.
set grepprg=rg\ --vimgrep grepformat=%f:%l:%c:%m " Use a faster grep.

if has('vim_starting')
  let startup = reltime()
  autocmd VimEnter * let ready = reltime(startup) | redraw | echo reltimestr(ready)
endif

augroup end
