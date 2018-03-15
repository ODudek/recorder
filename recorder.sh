#!/usr/bin/env bash

function screenrecord {
    local file
    local path
    path=${2}
    file="/sdcard/${1}.mp4"
    fetch_screenrecord()
	{
		echo -e "\nFetching $file"
		sleep "${2:-1}"
		adb pull $file $path && adb shell rm $file
	}
	echo 'Press Ctrl+C to stop recording'
	trap fetch_screenrecord INT
	adb shell screenrecord $file
	unset fetch_screenrecord
}

while getopts n:p option 
do
    case "${option}"
    in
        n) NAME=${OPTARG};;
        p) FILEPATH=${OPTARG};;
    esac
done

screenrecord ${NAME} ${FILEPATH}
