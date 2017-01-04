#!/bin/bash
#
# Filename: mp4_to_webm_cbr.sh
#
# Author: Philip Wyett - philwyett.rebellion@gmail.com
#

#
# Check 'ffmpeg' is installed and available.
#
# If 'ffmpeg' is not installed and available, then exit.
#
if ! [ -x "$(command -v ffmpeg)" ]; then
    echo 'ffmpeg is not installed. Exiting...' >&2
    exit 1
fi

#
# Convert our 'mp4' files to 'webm'.
#
# Delete 'mp4' files once converted.
#
if stat -t ./*.mp4 >/dev/null 2>&1 ; then
    for filename in *.mp4
    do
        filename=${filename%.mp4}
        ffmpeg -i "$filename".mp4 -c:v libvpx-vp9 -minrate 1M -maxrate 1M -b:v 1M -c:a libvorbis "$filename".webm
        rm -f "$filename".mp4
    done
fi
