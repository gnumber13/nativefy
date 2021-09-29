#!/bin/sh 
#source ./nativefy.conf


npm_version=$(npm -v)
[ npm_version == "" ] || echo "npm v$npm_version is available"

electron_version=default


# checking if an electron version is installed as npm package
npm_electron_version=$(npm list electron | grep electron | cut -d'@' -f2)
[ npm_electron_version == "" ] && echo "check1 no npm electron version available (npm)" || echo "electron v$npm_electron_version available(npm)"

default_el_version=$(electron -v | cut -c2-)
[ $electron_version == default ] && build_electron_version=$default_el_version \
    || echo "info: electron_version is not set to default"

# making sure electron is installed
[ $build_electron_version == $default_el_version ] && echo "electron v$default_el_version available(system)" \
    || "nativefier is not installed use 'npm install electron'"

# making sure nativefier is installed
nativefier_version=$(npm list nativefier | grep nativefier | cut -d'@' -f2)

[ $nativefier_version != "" ] && echo "nativefier v$nativefier_version is available(npm only)" \
    || "nativefier is not installed use 'npm install nativefier'"

# making sure nativefier is directly callable
nativefier --version || echo "nativefier not in $PATH"
