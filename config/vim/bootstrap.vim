"
" Compatibility
"

" Don't be VI-compatible.
set nocompatible
" Use a POSIX shell no matter what.
set shell=/bin/sh

"
" Functions
"

function! EnsureDir(dir)
    let target = expand(a:dir)
    if empty(glob(target))
        try
            call mkdir(target, "p")
        catch
            silent execute "!mkdir -p ".target
        endtry
    endif
endfunction

"
" Bootstrapping
"

filetype off
autocmd!

let g:dir = has('win32') ? '~/Application Data/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
let g:bundle_dir    = g:dir."/bundle"
let g:neobundle_dir = g:bundle_dir."/neobundle.vim"
let g:neobundle_git = "git://github.com/Shougo/neobundle.vim.git"

call EnsureDir(g:dir)
call EnsureDir(g:bundle_dir)

if empty(glob(g:neobundle_dir))
    silent execute "!git clone ".g:neobundle_git." ".g:neobundle_dir
endif

" Activate NeoBundle.
silent execute "set runtimepath+=".g:neobundle_dir
call neobundle#rc(g:bundle_dir)

" Let NeoBundle manage itself.
NeoBundleFetch "Shougo/neobundle.vim"

"
" Auto-reloading
"

augroup reload
    autocmd!
    autocmd bufwritepost * source $MYVIMRC
augroup end
