#!/bin/bash

WALLS_DIR="$HOME/Pictures/todayswalls"

# Move scripts over and create rolling wallpaper
#
cp ~/ragebox/git/wallpapers/createSlideshow.sh ~/Pictures/todayswalls/createSlideshow.sh
~/Pictures/todayswalls/createSlideshow.sh 15

# Clean up the folder
#
cd "${WALLS_DIR}"

rm link*
rm *.sh
