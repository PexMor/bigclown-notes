BD="$HOME/pootle"
D="$BD/dbdata"
CFG="$BD/my.conf"

PASS=pass

if [ -f "$CFG" ]; then
    # replace default password with custom
    source "$CFG"
fi

[ -d "$D" ] || mkdir -p "$D"
