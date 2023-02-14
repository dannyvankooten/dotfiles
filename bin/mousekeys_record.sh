Y=$(xdotool getmouselocation | awk -F'[ :]' '{print $4}')
X=$(xdotool getmouselocation | awk -F'[ :]' '{print $2}')

# If we're hooked up to an external monitor
# Subtract width of 1st screen from X coordinate
NUM_DISPLAYS=$(swaymsg -t get_outputs | jq '. | length')
if [[ $NUM_DISPLAYS = "2" ]]; then
    X=$(calc "$X - 1920")
fi

echo $X > $HOME/.local/share/mousekeys_x 
echo $Y > $HOME/.local/share/mousekeys_y
