#!/bin/bash

#----------------
# Name          : doc_args_tests.bash
# Project       : scanz
# Description   : Unit tests for reading doc-mode arguments
#----------------

source "./_src/args/doc_args.bash"
source "./_src/utils/fs.bash"

test_read_doc_args_with_no_supplied_args() {
  local message="It should return default arguments and ask user to select a scanner."
  local test_selected_scanner="test_scanner"
  user_select_scanner() { echo "$test_selected_scanner" ; }
  local test_color_mode=`color_mode_color`
  local test_quality=`default_doc_quality`
  local test_output_dir=`default_output_dir`
  local test_output_file_name=`default_file_name`
  local expected_result="$test_selected_scanner $test_color_mode $test_quality $test_output_dir $test_output_file_name"

  local result=`read_doc_args`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_doc_args_with_gray_color_mode_arg() {
  local message="It should return gray color mode and otherwise default arguments."
  local test_selected_scanner="test_scanner"
  user_select_scanner() { echo "$test_selected_scanner" ; }
  local test_color_mode=`color_mode_gray`
  local test_quality=`default_doc_quality`
  local test_output_dir=`default_output_dir`
  local test_output_file_name=`default_file_name`
  local expected_result="$test_selected_scanner $test_color_mode $test_quality $test_output_dir $test_output_file_name"

  local result=`read_doc_args -g`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_doc_args_with_all_short_args_supplied() {
  local message="It should return all configured arguments."
  local test_selected_scanner="test_scanner"
  user_select_scanner() { echo "$test_selected_scanner" ; }
  local test_color_mode="gray"
  local test_quality="999"
  local test_output_dir="/home/me/out"
  local test_output_file_name="MyScan"
  local expected_result="$test_selected_scanner $test_color_mode $test_quality $test_output_dir $test_output_file_name"

  local result=`read_doc_args -i "$test_selected_scanner" -q "$test_quality" -d "$test_output_dir" -o "$test_output_file_name" -g`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_doc_args_with_all_long_args_supplied() {
  local message="It should return all configured arguments."
  local test_selected_scanner="test_scanner"
  user_select_scanner() { echo "$test_selected_scanner" ; }
  local test_color_mode="gray"
  local test_quality="999"
  local test_output_dir="/home/me/out"
  local test_output_file_name="MyScan"
  local expected_result="$test_selected_scanner $test_color_mode $test_quality $test_output_dir $test_output_file_name"

  local result=`read_doc_args --scanner "$test_selected_scanner" --quality "$test_quality" --output_dir "$test_output_dir" --output_name "$test_output_file_name" --grayscale`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

