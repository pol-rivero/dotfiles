#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    # wpctl returns "Volume: 0.30", multiply by 100 to get an integer
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
}

function is_mute {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED
}

function send_notification {
    DIR=`dirname "$0"`
    volume=$(get_volume)
    volumeText="Volume: $volume%"

    if [ "$volume" = "0" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-muted.svg"
    elif [ "$volume" -lt "10" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
    elif [ "$volume" -lt "30" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-low.svg"
    elif [ "$volume" -lt "70" ]; then
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-medium.svg"
    else
        icon_name="/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-high.svg"
    fi

    $DIR/notify-send.sh "$volumeText" -i "$icon_name" -t 2000 -h int:value:"$volume" --replace=555
    paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 2%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 2%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
    DIR=`dirname "$0"`
    $DIR/notify-send.sh -i "/usr/share/icons/Faba/48x48/notifications/notification-audio-volume-muted.svg" --replace=555 -u normal "Audio muted" -t 2000  --app-name=VolumeNotification
	else
	    send_notification
	fi
	;;
esac
