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


