#!/bin/bash

#----------------
# Name          : preview_args_tests.bash
# Project       : scanz
# Description   : Unit tests for reading preview arguments
#----------------

source "./_src/args/preview_args.bash"

test_read_mode_arg_with_no_supplied_args() {
  local message="It should return false."
  local expected_result="false"

  local result=`read_preview_args`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_mode_arg_with_all_short_args() {
  local message="It should return false."
  local expected_result="true"

  local result=`read_preview_args -p`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_mode_arg_with_all_long_args() {
  local message="It should return false."
  local expected_result="true"

  local result=`read_preview_args --preview`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

