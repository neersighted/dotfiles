" C/C++
autocmd vimrc FileType c,cpp  nnoremap <buffer> <c-]> :call g:ClangGotoDeclaration()<cr>

" Go
autocmd vimrc FileType go nnoremap <buffer> <c-]> :call go#def#Jump('buf')<cr>

" Python
autocmd vimrc FileType python nnoremap <buffer> <c-]> :call jedi#goto_definitions()<cr>

" Quickfix
" enable numbering, disable visual wrapping
autocmd vimrc FileType qf setlocal number norelativenumber nowrap

" Text
" enable spellchecking
autocmd vimrc FileType gitcommit,markdown,text setlocal spell

" Vim
autocmd vimrc FileType vim setlocal keywordprg=:help
