function run_gpg-agent --description 'run the gpg-agent'
  function __refresh_gpg_info
    if test -n "$argv[1]"
      set gpginfo $argv[1]
    else
      set gpginfo $GPGINFO
    end

    if [ -f $gpginfo ]
      sed 's/=/ /' $gpginfo | while read key value
        set -gx $key $value
      end
    end
  end

  set -q GPGINFO; or set -gx GPGINFO /tmp/gpg-agent.info
  set -q PINENTRY; or set -gx PINENTRY /usr/bin/pinentry-curses
  if [ -x /usr/bin/gpg-agent ]
    __refresh_gpg_info $GPGINFO

    if not pgrep -u $USER gpg-agent >/dev/null ^&1
      gpg-agent --daemon \
        --enable-ssh-support \
        --pinentry-program $PINENTRY \
        --write-env-file $GPGINFO \
        >/dev/null ^&1
      chmod 600 $GPGINFO

      __refresh_gpg_info $GPGINFO
    end
  end
end
