#!/bin/bash

#----------------
# Name          : mode_args_tests.bash
# Project       : scanz
# Description   : Unit tests for reading mode arguments
#----------------

source "./_src/args/mode_args.bash"
source "./_src/messages/errors.bash"

test_read_mode_arg_with_no_supplied_args() {
  local message="It should throw a missing-required-args error."
  local expected_result=`error_missing_required_arg "mode" "read_mode_args"`

  local result=`read_mode_args`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_mode_arg_with_unknown_mode_short_arg() {
  local message="It should throw a mode-not-found error."
  local test_mode="test"
  local expected_result=`error_mode_not_found "test" "read_mode_args"`

  local result=`read_mode_args -m "$test_mode"`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_mode_arg_with_known_mode_short_arg() {
  local message="It should return the name of the configured mode."
  local test_mode="doc"
  local expected_result="$test_mode"

  local result=`read_mode_args -m "$test_mode"`

  assertEquals "$message" "$expected_result" "$result"
}

test_read_mode_arg_with_known_mode_long_arg() {
  local message="It should return the name of the configured mode."
  local test_mode="doc"
  local expected_result="$test_mode"

  local result=`read_mode_args --mode "$test_mode"`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

