#!/bin/bash

# Toggles the hard drive automatic mounting in the drive back 
# WARNING: program assumes last line in fstab file is drive to be switched

declare -gr FSTAB_PATH="/etc/fstab"

# checks if the drive is commented out or not
function state(){
	
	if [[ $(cat $FSTAB_PATH | tail -n 1 | egrep -c "^#") -eq 0 ]]; then
		echo 0
	else
		echo 1
	fi
}

# toggles the drive from being mounted to unmounted and vise-versa
function switch() {

	if [[ $(state) -eq 1 ]]; then
	#uncomment drive
	sudo sed -ie "$ s/#//" $FSTAB_PATH
	else
		sudo sed -ie "$ s/\(.*\)$/#\1/" $FSTAB_PATH # comments out the drive
	fi
}

case "$1" in

	flip)
		switch
	
	status)
		if [[ $(state) -eq 1 ]]; then
			echo "Drive in disabled state"
		else
			echo "Drive in enabled state"
		fi

		exit
	;;
	
	*)
		>&2 echo "invalid arguemnt: $1 or no arguement given"
		exit 1
	;;
esac







