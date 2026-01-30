#!/bin/bash
current=$(setxkbmap -query | grep layout | awk '{print $2}')
if [[ "$current" == "us" ]]; then
    setxkbmap cz
else
    setxkbmap us
fi
