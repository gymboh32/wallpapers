#!/bin/bash

#
# Author: Flynsarmy
# Contributor: Ariel Barabas (ariel.baras atGmail)
#


#interval in seconds
INTERVAL=1800
OUTFILE=backgrounds.xml
DIR=$(pwd)

if [ $1 ]; then
	if [ $1 == "--help" ]; then
		echo "	Creates the background configuration xml file with 30min of delay between pictures with the images found in the same directory, you can modify that delay entering other number
Example:
	./createSlideShow.sh 15		makes the delay of 15 minutes"
		exit
	else
		INTERVAL=$(expr $1 \* 60)
	fi
fi
echo ${DIR}

echo "<background>
  <starttime>
    <year>2009</year>
    <month>08</month>
    <day>04</day>
    <hour>00</hour>
    <minute>00</minute>
    <second>00</second>
  </starttime>
" > $OUTFILE

while read -r IMG;
do
	if [ "$FIRST_IMG" ]; then
		echo "<transition>
	<duration>5.0</duration>
	<from>$DIR/$LAST_IMG</from>
	<to>$DIR/$IMG</to>
</transition>" >> $OUTFILE
	else
		FIRST_IMG="$IMG"
	fi

	echo "<static>
	<duration>$INTERVAL</duration>
	<file>$DIR/$IMG</file>
</static>

" >> $OUTFILE
done < <(find -name "*.jpg" -o -name "*.png" -o -name "*.gif" | shuf)

echo "<transition>
	<duration>5.0</duration>
	<from>$DIR/$LAST_IMG</from>
	<to>$DIR/$FIRST_IMG</to>
</transition>

</background>" >> $OUTFILE

if hash gsettings &>/dev/null; then
	gsettings set org.gnome.desktop.background picture-uri "file://$DIR/$OUTFILE"
else
	gconftool-2 -t string --set /desktop/gnome/background/picture_filename "$DIR/$OUTFILE"
fi
