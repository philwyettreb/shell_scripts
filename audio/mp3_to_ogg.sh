#!/bin/bash
#
# Filename: mp3_to_ogg.sh
#
# Author: Philip Wyett - philwyett.rebellion@gmail.com
#

#
# Check 'mpg123' is installed and available.
#
if ! [ -x "$(command -v mpg123)" ]; then
	echo 'mpg123 is not installed.' >&2
	exit 1
fi

#
# Check 'oggenc' is installed and available.
#
if ! [ -x "$(command -v oggenc)" ]; then
	echo 'oggenc is not installed.' >&2
	exit 1
fi

#
# Convert our mp3 files back to wav
#
if stat -t *.mp3 >/dev/null 2>&1 ; then
	for filename in *.mp3
	do
		filename=${filename%.mp3}
		mpg123 -w "$filename".wav "$filename".mp3
		rm -f "$filename".mp3
	done
fi

#
# Ogg encode our wav files.
#
if stat -t *.wav >/dev/null 2>&1 ; then
	for filename in *.wav
	do
		# Default quality is 5, change below to preferred '1 - 10'.
		oggenc -q 5 "$filename"
		rm -f "$filename"
	done
fi
