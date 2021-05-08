function is_macos
  set -q uname; or set -g uname (uname)
  test $uname = 'Darwin'
end
