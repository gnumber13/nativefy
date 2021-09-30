#!/usr/bin/env bats

@test "npm is installed" {
  result="$(npm -v > /dev/null && echo "installed" || echo "not installed" )"
  echo $result
  [ "$result" == "installed" ]
}

@test "electron(npm) is installed" {
  result="$(npm list electron | grep electron > /dev/null && echo "installed" || echo "not installed" )"
  echo $result
  [ "$result" == "installed" ]
}

@test "electron(system) is installed" {
  result="$(electron --version > /dev/null && echo "installed" || echo "not installed" )"
  echo $result
  [ "$result" == "installed" ]
}


@test "nativefier is installed" {
  result="$(npm list nativefier | grep nativefier > /dev/null && echo "installed" || echo "not installed" )"
  echo $result
  [ "$result" == "installed" ]
}

@test "nativefier is in \$PATH" {
  result="$(nativefier --version > /dev/null && echo "installed" || echo "not installed" )"
  echo $result
  [ "$result" == "installed" ]
}
