#!/bin/bash

source "./_src/scan-to-file.bash"

setUp() {
  unset -f get_presets
  get_presets() {
    echo "`mock_scanner` `mock_format` `mock_quality` `mock_time` `false` `false`"
  }
}

when_executing_main() {
  local message="It should" 
  local expected_result="Mode not deteced. Nothing scanned."

  local result=`main`

  assertEquals "${message}" "${expected_result}" "${result}"
}

#suite_addTest when_executing_main

