#!/bin/bash

WALLS_DIR="/home/jahall/ragebox/todayswalls"

# Move scripts over and create rolling wallpaper
#
cp ~/ragebox/git/wallpapers/createSlideshow.sh "${WALLS_DIR}"/createSlideshow.sh
cd "${WALLS_DIR}"
./createSlideshow.sh 15

# Clean up the folder
#
#cd "${WALLS_DIR}"

rm link*
rm *.sh
