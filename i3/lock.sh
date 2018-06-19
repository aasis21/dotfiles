#!/bin/bash

#scrot /tmp/screen_locked.png
# Pixellate it 10x
#mogrify -scale 10% -scale 1000% /tmp/screen_locked.png
# Lock screen displaying this image.
i3lock -i ~/.config/i3/images/lock.png -c 000000

# Turn the screen off after a delay.
sleep 30; pgrep i3lock && xset dpms force off
