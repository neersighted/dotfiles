if command -sq rg
  function rg
    if isatty stdout
      command rg -p $argv | less -RMFXK
    else
      command rg $argv
    end
  end
end
