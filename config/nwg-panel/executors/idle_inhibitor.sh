#!/bin/bash

# You can check current locks with `systemd-inhibit --list`

# Operations to inhibit, colon separated list of: shutdown, sleep, idle, handle-power-key, handle-suspend-key, handle-hibernate-key, handle-lid-switch
WHAT="idle"
TEXT_ACTIVE=" SLEEP DISABLED"
TEXT_INACTIVE=""

NWG_RT_SIGNAL=34

LOCK_FILE="/tmp/nwg-panel-inhibitor-toggle.lock"

status() {
    if [ -f "$LOCK_FILE" ]; then
        echo "$TEXT_ACTIVE"
    else
        echo "$TEXT_INACTIVE"
    fi
}

toggle() {
    if [ -f "$LOCK_FILE" ]; then
        pid=$(cat "$LOCK_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            echo "Stopping inhibition (PID $pid)..."
            kill "$pid"
        fi
        rm -f "$LOCK_FILE"
        echo "$WHAT is no longer inhibited"
    else
        echo "Starting inhibition..."
        systemd-inhibit --what="$WHAT" --mode=block --why="User manually inhibited $WHAT" --who="nwg-panel" sleep infinity &
        echo $! > "$LOCK_FILE"
        echo "$WHAT is now inhibited"
    fi
    pkill -$NWG_RT_SIGNAL nwg-panel
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {status|toggle}"
    exit 1
fi

case "$1" in
    status)
        status
        ;;
    toggle)
        toggle
        ;;
    *)
        echo "Invalid command: $1"
        echo "Usage: $0 {status|toggle}"
        exit 1
        ;;
esac
