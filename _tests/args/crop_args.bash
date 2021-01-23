#!/bin/bash

#----------------
# Name          : doc_args_tests.bash
# Project       : scanz
# Description   : Unit tests for reading doc-mode arguments
#----------------

source "./_src/args/doc_args.bash"
source "./_src/utils/fs.bash"

test_read_crop_args_with_no_args() {
  local message="It should return default arguments."
  local expected_result=`default_input_dir`

  local result=`read_crop_args`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_crop_args_with_all_short_args() {
  local message="It should return all supplied arguments."
  local test_input_dir="/home/me/out"
  local expected_result="$test_input_dir"

  local result=`read_crop_args -i $test_input_dir`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_crop_args_with_all_long_args() {
  local message="It should return all supplied arguments."
  local test_input_dir="/home/me/out"
  local expected_result="$test_input_dir"

  local result=`read_crop_args --input_dir $test_input_dir`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

