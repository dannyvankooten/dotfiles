RAND_X=$((-5 + $RANDOM % 15))
RAND_Y=$((-5 + $RANDOM % 12))
X=$(cat $HOME/.local/share/mousekeys_x)
Y=$(cat $HOME/.local/share/mousekeys_y)
X=$(calc "$X + $RAND_X")
Y=$(calc "$Y + $RAND_Y")

swaymsg "seat * cursor set $X $Y"
