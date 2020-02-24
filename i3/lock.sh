#!/bin/bash

# Lock screen displaying this image.
i3lock -i ~/.config/i3/images/lock.png -c 000000

# Turn the screen off after a delay.
sleep 2; xset dpms force off
