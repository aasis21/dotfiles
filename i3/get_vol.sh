#!/bin/bash
t=$(x=$(pactl list sinks >.ttemp;cat .ttemp| grep -n "State: RUNNING"|sed 's/[^0-9]//g');cat .ttemp|head -$((x-1))| tail -1|sed 's/[^0-9]//g')
VOLUME=$(pactl list sinks | grep "Sink #$t\|^[[:space:]]Volume:" | grep -A 1 "Sink #$INDEX" | grep "^[[:space:]]Volume" | awk '{print $5}');
echo $VOLUME