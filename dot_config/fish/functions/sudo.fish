command -q sudo; or exit

function sudo
  if test $argv[1] = nvim
    set -e argv[1]
    command sudo -e $argv
  else
    command sudo $argv
  end
end
