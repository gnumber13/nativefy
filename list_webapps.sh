#!/bin/sh   

source ./nativefy.conf

ls $webapps_folder -1 | cut -d'-' -f1
