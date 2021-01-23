#!/bin/bash

#----------------
# Name          : verbose_args_tests.bash
# Project       : scanz
# Description   : Unit tests for reading verbose arguments
#----------------

source "./_src/args/verbose_args.bash"

test_read_verbose_arg_with_no_supplied_args() {
  local message="It should return false."
  local expected_result="false"

  local result=`read_verbose_args`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_verbose_arg_with_all_short_args() {
  local message="It should return false."
  local expected_result="true"

  local result=`read_verbose_args -v`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_verbose_arg_with_all_long_args() {
  local message="It should return false."
  local expected_result="true"

  local result=`read_verbose_args --verbose`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

