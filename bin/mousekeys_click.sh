swaymsg "seat * cursor press button1"

RANDOM_SLEEP=$((1 + $RANDOM % 105))
sleep "0.{$RANDOM_SLEEP}s"

swaymsg "seat * cursor release button1"
