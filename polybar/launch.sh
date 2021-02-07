#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1
# polybar main -r &
if type "xrandr"; then
    PRIMARY_QUERY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
    OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)
    PRIMARY=${PRIMARY_QUERY:="DisplayPort-1"}

    MONITOR=$PRIMARY polybar main -c $HOME/.config/polybar/config -r 2>$HOME/.config/polybar/primary.log &
    for m in $OTHERS; do
        if [[ $m == "DP-0" ]]; then
            continue
        fi
        MONITOR=$m polybar secondary -c $HOME/.config/polybar/config.secondary -r 2>$HOME/.config/polybar/others.log &
    done
else
    polybar main -r &
fi
