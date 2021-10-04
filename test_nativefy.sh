#!/usr/bin/env bats

. ./units.sh
. ./nativefy.conf

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
  [ "$result" == "15.1.0" ]
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
mkdir -p $webapps_folder
mkdir -p $webapps_folder/testwebapp-linux-x64
echo "{\"name\": \"testdata\"}" > $webapps_folder/testwebapp-linux-x64/package.json
start_path=$(pwd)
create_desktop_file "Test Webapp" testwebapp
cd $start_path
result="$(cat $webapps_folder/testwebapp-linux-x64/testwebapp.desktop > /dev/null && echo true || echo false)"
echo $result
rm -r $webapps_folder/testwebapp-linux-x64
[ "$result" == "true" ]
}

@test "creating a .desktop file, testing if successfully written to" {
mkdir -p $webapps_folder/testwebapp-linux-x64/resources/app
echo "{\"name\": \"testdata\"}" > $webapps_folder/testwebapp-linux-x64/resources/app/package.json
start_path=$(pwd)
create_desktop_file "Test Webapp" testwebapp
cd $start_path
result="$(cat $webapps_folder/testwebapp-linux-x64/testwebapp.desktop | grep testdata > /dev/null && echo true || echo false)"
echo $result
rm -rf $webapps_folder/testwebapp-linux-x64 ~/.local/share/applications/testwebapp.desktop
[ "$result" == "true" ]
}

@test "test copying of .desktop file" {
echo test > tmp.desktop
copy_desktop_file_to_directory tmp.desktop ~/.local/share/applications/
result="$(cat ~/.local/share/applications/tmp.desktop)"
rm tmp.desktop ~/.local/share/applications/tmp.desktop
  echo $result
  [ "$result" == "test" ]
}


@test "test creating symlink" {
echo "echo test" > tmp.sh
chmod +x tmp.sh
create_symlink_to_user_path tmp.sh ~/.local/bin/tmp.sh
result="$(tmp.sh)"
#rm tmp.sh ~/.local/bin/tmp.sh
  echo $result
  [ "$result" == "test" ]
}
