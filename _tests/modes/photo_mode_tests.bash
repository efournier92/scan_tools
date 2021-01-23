#!/bin/bash

#----------------
# Name          : photo_mode_tests.bash
# Project       : scanz
# Description   : Unit tests for photo-mode functionality
#----------------

source "./_src/modes/photo_mode.bash"

test_get_scan_photo_command_with_missing_args() {
  local message="It should throw a missing-function-args error."
  local expected_result=`error_missing_function_args "get_scan_photo_command" "$@"`

  local result=`get_scan_photo_command`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_scan_photo_command_with_all_args() {
  local message="It should return a scanimage command with all configured arguments."
  local test_scanner="test_scanner_0"
  local test_color_mode="color"
  local test_quality="999"
  local test_output_location="/home/me/out"

  local expected_result="scanimage -d $test_scanner --progress --format=png --mode $test_color_mode --resolution $test_quality -o $test_output_location"

  local result=`get_scan_photo_command "$test_scanner" "$test_color_mode" "$test_quality" "$test_output_location"`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

