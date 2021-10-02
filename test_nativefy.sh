#!/usr/bin/env bats

source ./units.sh

@test "to_lower_and_snake_case" {
result=$(to_lower_and_snake_case "Deutsche Bahn")
  echo $result
  [ "$result" == "deutsche_bahn" ]
}

@test "test get electron version to build default" {
result="$(get_build_electron_version default)"
  echo $result
  [ "$result" == "14.0.1" ]
}

@test "test get electron version to build system" {
result="$(get_build_electron_version system)"
  echo $result
  [ "$result" == "14.0.1" ]
}

@test "test get electron version to build npm" {
result="$(get_build_electron_version npm)"
  echo $result
  [ "$result" == "15.0.0" ]
}

@test "test get electron version to build other" {
result="$(get_build_electron_version 8.0.0)"
  echo $result
  [ "$result" == "custom electron versions are unsupported right now" ]
}

@test "test webpage availability succeeding" {
result="$(is_webpage_up archlinux.org)"
  echo $result
  [ "$result" == "true" ]
}

@test "test webpage availability failing" {
result="$(is_webpage_up archlinuxxx.org)"
  echo $result
  [ "$result" == "false" ]
}

@test "test retrieving json data" {
echo "{\"name\": \"testdata\"}" > tmp1.json
result="$(get_wm_class tmp1.json)"
rm tmp1.json
  echo $result
  [ "$result" == "testdata" ]
}

@test "creating a .desktop file, testing if created" {
mkdir -p webapps
mkdir -p webapps/testwebapp-linux-x64
echo "{\"name\": \"testdata\"}" > webapps/testwebapp-linux-x64/test_package.json

start_path=$(pwd)
create_desktop_file testwebapp
cd $start_path

result="$(cat webapps/testwebapp-linux-x64/testwebapp.desktop > /dev/null && echo true || echo false)"
echo $result

rm -r webapps/testwebapp-linux-x64
[ "$result" == "true" ]
}

@test "creating a .desktop file, testing if successfully written to" {
mkdir -p webapps
mkdir -p webapps/testwebapp-linux-x64
echo "{\"name\": \"testdata\"}" > webapps/testwebapp-linux-x64/test_package.json

start_path=$(pwd)
create_desktop_file testwebapp
cd $start_path

result="$(cat webapps/testwebapp-linux-x64/testwebapp.desktop | grep testdata > /dev/null && echo true || echo false)"
echo $result

rm -r webapps/testwebapp-linux-x64

[ "$result" == "true" ]
}
