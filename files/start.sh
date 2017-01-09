#! /bin/sh -e

function first
{
  echo $1
}

function rest
{
  shift
  echo $@
}

date > /srv/nfs/tst-run

mount -t nfsd nfsd /proc/fs/nfsd

/usr/sbin/rpcbind -w -f &
/usr/sbin/rpc.statd &
/usr/sbin/rpc.idmapd &
/usr/sbin/exportfs -r &
/usr/sbin/rpc.nfsd &

# /usr/bin/service nfs start

waits="1 1 2 4 8 16 32 64 360"

while pidof rpc.nfsd > /dev/null; do
    date
    echo "NFSd proces" $(pidof rpc.nfsd)
    sleep $(first $waits)
    if [ "x$(rest $waits)" != "x" ]; then
        waits="$(rest $waits)"
    fi
    echo
done

if ! pidof rpc.nfsd; then
    echo "NFSd is not running."
fi
