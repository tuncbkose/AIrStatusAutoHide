#!/bin/bash

# Hide Airpods Battery status GNOME extension when Airpods are not connected.

# I am assuming when this script is run bluetooth and extension state will correspond but it should be fine if they don't.

AirStatusAutoHide_Hidden=1 # If 1, Airpods should be disconnected and extension should be hidden
AirStatusAutoHide_ExtensionUUID="airpods-battery-status@ju.wtf"


while true
do
    if [ ! "$(bluetoothctl info | grep "AirPods")" ]
    then
	if ((AirStatusAutoHide_Hidden))
	then  # Airpods disconnected, extension hidden, do nothing
	    :
	else  # Airpods disconnected, extension is visible, need to hide it
	    gnome-extensions disable $AirStatusAutoHide_ExtensionUUID
	    AirStatusAutoHide_Hidden=1
	fi
    else
	if ((AirStatusAutoHide_Hidden))
	then # Airpods connected, extension hidden, need to make it visible
	    gnome-extensions enable $AirStatusAutoHide_ExtensionUUID
	    AirStatusAutoHide_Hidden=0
	else # Airpods connected, extension visible, do nothing
	    :
	fi
    fi
    sleep 10
done
