#!/bin/sh

source ./nativefy.conf

echo "removing $webapps_folder/$1-linux-*"
rm -r $webapps_folder/$1-linux-*

echo "removing $user_appliations_directory/$1.desktop"
rm $user_appliations_directory/$1.desktop

echo "removing ~/.config/$1*"
rm -r ~/.config/$1-nativefier*
