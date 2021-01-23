#!/bin/bash

#----------------
# Name          : time_tests.bash
# Project       : scanz
# Description   : Unit tests for time functions
#----------------

source "./_src/utils/time.bash"

test_get_time_now() {
  local message="It should return the time now in the expected format."
  local expected_result="$(date '+%y-%m-%d_%H%M%S')"

  local result=`get_time_now`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

