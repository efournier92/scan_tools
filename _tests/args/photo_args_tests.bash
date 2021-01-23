#!/bin/bash

#----------------
# Name          : photo_args_tests.bash
# Project       : scanz
# Description   : Unit tests for reading photo-mode arguments
#----------------

source "./_src/args/photo_args.bash"
source "./_src/utils/constants.bash"
source "./_src/utils/fs.bash"

test_read_mode_arg_with_no_supplied_args() {
  local message="It should return all default arguments."
  local test_scanner="test_scanner_0"
  user_select_scanner() { echo "$test_scanner" ; }
  local test_color_mode=`color_mode_color`
  local test_quality=`default_photo_quality`
  local test_output_dir=`default_output_dir`
  local test_output_name=`default_file_name`
  local expected_result="$test_scanner $test_color_mode $test_quality $test_output_dir $test_output_name"

  local result=`read_photo_args`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_mode_arg_with_all_short_args() {
  local message="It should return all default arguments."
  local test_scanner="test_scanner_0"
  local test_color_mode=`color_mode_gray`
  local test_quality="999"
  local test_output_dir="/home/me/out"
  local test_output_name="TestPhotoScan"
  local expected_result="$test_scanner $test_color_mode $test_quality $test_output_dir $test_output_name"

  local result=`read_photo_args -i $test_scanner -g -q $test_quality -d $test_output_dir -o $test_output_name `

  assertEquals "$message" "$expected_result" "$result"
}

test_read_mode_arg_with_all_long_args() {
  local message="It should return all default arguments."
  local test_scanner="test_scanner_0"
  local test_color_mode=`color_mode_gray`
  local test_quality="999"
  local test_output_dir="/home/me/out"
  local test_output_name="TestPhotoScan"
  local expected_result="$test_scanner $test_color_mode $test_quality $test_output_dir $test_output_name"

  local result=`read_photo_args --scanner $test_scanner --grayscale --quality $test_quality --output_dir $test_output_dir --output_name $test_output_name `

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

