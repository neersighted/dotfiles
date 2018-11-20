function mosh --description 'mobile shell with roaming and intelligent local echo'
  command mosh --server="env COLORTERM= mosh-server" $argv
end
