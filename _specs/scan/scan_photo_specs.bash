#!/bin/bash

source ./scan/scan_photo.bash
source ./constants/constants.bash

when_building_a_scan_photo_command_and_all_arguments_supplied() {
  local message="It should"
  local scanner="scanner:test:9:9"
  local format="jpeg"
  local quality="300"
  local output_name="MyScan"
  local expected_result="scanimage -d ${scanner} --progress --format=${format} --resolution ${quality} -o ${output_name}.jpeg"

  local result=`build_scan_photo_command "${scanner}" "${format}" "${quality}" "${output_name}"`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_building_a_scan_photo_command_and_no_arguments_are_supplied() {
  local message="It should"
  local format="jpeg"
  local quality="300"
  local output_name="MyScan"
  local expected_result=`message_scanner_not_supplied`

  local result=`build_scan_photo_command`

  assertEquals "${message}" "${expected_result}" "${result}"
}

suite_addTest when_building_a_scan_photo_command_and_all_arguments_supplied
suite_addTest when_building_a_scan_photo_command_and_no_arguments_are_supplied

