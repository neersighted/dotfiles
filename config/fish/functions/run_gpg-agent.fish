function run_gpg-agent --description 'run the gpg-agent'
    if [ -x /usr/bin/gpg-agent ]
        set -l gpginfo /tmp/gpg-agent.info
        if not pgrep -u $USER gpg-agent >/dev/null ^&1
            gpg-agent --daemon --enable-ssh-support --write-env-file $gpginfo >/dev/null
            chmod 600 $gpginfo
        end
        if [ -f $gpginfo ]
            for l in (cat $gpginfo)
                set -gx (echo $l | cut -d= -f1) (echo $l | cut -d= -f2)
            end
        end
    end
end
