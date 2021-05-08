function is_freebsd
  set -q uname; or set -g uname (uname)
  test $uname = 'FreeBSD'
end
