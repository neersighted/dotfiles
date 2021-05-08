function is_linux
  set -q uname; or set -g uname (uname)
  test $uname = 'Linux'
end
