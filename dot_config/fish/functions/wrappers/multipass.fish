if command -q multipass.exe
  function multipass -w multipass.exe
    multipass.exe $argv
  end
end
