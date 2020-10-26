#!/bin/bash

source ./utils/fs.bash

when_getting_temp_tiff_dir_and_output_name_is_supplied() {
  local message="It should return properly fomatted dir name"
  local output_name="MyScan"
  local expected_result="scan_${output_name}"

  local result=`get_temp_tiff_dir "${output_name}"`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_getting_temp_tiff_dir_and_output_name_is_not_supplied() {
  local message="It should return a RequiredArguments error"
  local expected_result="ERROR: Required argument(s) missing from get_temp_tiff_dir"
  local result=`get_temp_tiff_dir`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_getting_temp_tiff_concat_file_and_sequence_name_is_supplied() {
  local message="It should return properly fomatted file name"
  local temp_sequence_name="MyScan"
  local expected_result="scan_${output_name}"

  local result=`get_temp_tiff_dir "${output_name}"`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_getting_temp_tiff_dir_and_output_name_is_not_supplied() {
  local message="It should return properly fomatted dir name"
  local expected_result="ERROR: Required argument(s) missing from get_temp_tiff_dir"
  local result=`get_temp_tiff_dir`

  assertEquals "${message}" "${expected_result}" "${result}"
}

suite_addTest when_getting_temp_tiff_dir_and_output_name_is_supplied
suite_addTest when_getting_temp_tiff_dir_and_output_name_is_not_supplied

