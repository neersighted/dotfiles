function! util#has_colorscheme(name) abort
  return !empty(globpath(&runtimepath, 'colors/'.a:name.'.vim', v:true))
        \ || !empty(globpath(&runtimepath, 'colors/'.a:name.'.lua', v:true))
        \ || !empty(globpath(&packpath, 'pack/*/start/*/colors/'.a:name.'.vim', v:true))
        \ || !empty(globpath(&packpath, 'pack/*/opt/*/colors/'.a:name.'.vim', v:true))
        \ || !empty(globpath(&packpath, 'pack/*/start/*/colors/'.a:name.'.lua', v:true))
        \ || !empty(globpath(&packpath, 'pack/*/opt/*/colors/'.a:name.'.lua', v:true))
endfunction
