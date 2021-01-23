#!/bin/bash

#----------------
# Name          : modes_tests.bash
# Project       : scanz
# Description   : Unit tests for mode functions
#----------------

source "./_src/utils/modes.bash"
source "./_src/utils/constants.bash"
source "./_src/messages/errors.bash"

test_is_mode_known_and_no_mode_is_supplied() {
  local message="It should throw a missing-function-args error."
  local expected_result=`error_missing_function_args "is_mode_known"`

  local result=`is_mode_known`

  assertEquals "$message" "$expected_result" "$result"
}

test_is_mode_known_and_an_unknown_mode_is_supplied() {
  local message="It should return false"
  local mode="fake_mode"
  local expected_result="false"

  local result=`is_mode_known $mode`

  assertEquals "$message" "$expected_result" "$result"
}

test_is_mode_known_and_photo_mode_name_is_supplied() {
  local message="It should return true"
  local mode=`photo_mode_name`
  local expected_result="true"

  local result=`is_mode_known $mode`

  assertEquals "$message" "$expected_result" "$result"
}

test_is_mode_known_and_doc_mode_name_is_supplied() {
  local message="It should return true"
  local mode=`doc_mode_name`
  local expected_result="true"

  local result=`is_mode_known $mode`

  assertEquals "$message" "$expected_result" "$result"
}


test_is_mode_known_and_crop_mode_name_is_supplied() {
  local message="It should return true"
  local mode=`crop_mode_name`
  local expected_result="true"

  local result=`is_mode_known $mode`

  assertEquals "$message" "$expected_result" "$result"
}

test_is_mode_known_and_split_doc_mode_name_is_supplied() {
  local message="It should return true"
  local mode=`split_doc_mode_name`
  local expected_result="true"

  local result=`is_mode_known $mode`

  assertEquals "$message" "$expected_result" "$result"
}

test_is_mode_known_and_join_doc_mode_name_is_supplied() {
  local message="It should return true"
  local mode=`join_doc_mode_name`
  local expected_result="true"

  local result=`is_mode_known $mode`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

