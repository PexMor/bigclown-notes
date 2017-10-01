#!/bin/bash

mkdir -p /opt/bin
cat >/opt/bin/loopForever <<'DATA'
#!/bin/sh
PARAM=$1
if [ "x$PARAM" != "x" ]; then
    shift
    /usr/local/bin/$PARAM $*
    exit
fi
while true; do
    date
    sleep 30
done
DATA
chmod +x /opt/bin/loopForever

mkdir -p /usr/local/bin
cat >/usr/local/bin/ctl <<'DATA'
#!/bin/bash
echo "PARAMS = " $*
PARAM=$1
function help() {
    echo "usage: $0 {init|...}"
    echo
}
if [ "x$PARAM" = "x" ]; then
    help
    exit -1
fi
case "x$PARAM" in
    "xinit")
        echo "(Re)Initializing the environment"
        sudo -H cp -r /root/src/. /host/
    ;;
esac
DATA
chmod +x /usr/local/bin/ctl
