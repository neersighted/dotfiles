" Vim
autocmd vimrc FileType vim setlocal keywordprg=:help

" Text
" enable spellchecking
autocmd vimrc FileType gitcommit,markdown,text setlocal spell

" Quickfix
" enable numbering, disable visual wrapping
autocmd vimrc FileType qf setlocal number norelativenumber nowrap
