#!/bin/bash

#----------------
# Name          : help_args_tests.bash
# Project       : scanz
# Description   : Unit tests for reading arguments for printing help info
#----------------

source "./_src/args/help_args.bash"

test_read_help_arg_with_no_args() {
  local message="It should not print anything."
  local expected_result=""

  local result=`read_help_args`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_help_arg_with_short_arg_and_no_mode() {
  local message="It should print the full help menu."
  local expected_result=`print_help_by_mode`

  local result=`read_help_args -h`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_help_arg_with_long_arg_and_no_mode() {
  local message="It should print the full help menu."
  local expected_result=`print_help_by_mode`

  local result=`read_help_args --help`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_help_arg_with_known_mode_and_short_args() {
  local message="It should print the help menu for the known mode."
  local expected_result=`print_help_by_mode "doc"`

  local result=`read_help_args -m doc -h`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_help_arg_with_known_mode_and_long_args() {
  local message="It should print the help menu for the known mode."
  local expected_result=`print_help_by_mode "doc"`

  local result=`read_help_args --mode doc --help`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

