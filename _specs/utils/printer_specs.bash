#!/bin/bash

source ./utils/printer.bash

when_printing_a_line_and_no_arguments_are_supplied() {
  local message="It should use the default length"
  local expected_result="________________\n"

  local result=`print_line`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_printing_a_line_and_argument_is_supplied_line_length() {
  local message="It should"
  local line_length=10
  local expected_result="__________\n"

  local result=`print_line ${line_length}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_printing_a_line_and_all_arguments_are_supplied() {
  local message="It should"
  local line_length=10
  local line_char='+'
  local expected_result="++++++++++\n"

  local result=`print_line ${line_length} ${line_char}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

suite_addTest when_printing_a_line_and_no_arguments_are_supplied
suite_addTest when_printing_a_line_and_argument_is_supplied_line_length
suite_addTest when_printing_a_line_and_all_arguments_are_supplied

when_printing_a_header_and_no_arguments_are_supplied() {
  local message="It should "
  local expected_result="___\n???:\n"
  
  local result=`print_header`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_printing_a_header_and_header_name_argument_is_supplied() {
  local message="It should "
  local header_name="SELECT SCANNER"
  local expected_result="______________\n${header_name}:\n"
  
  local result=`print_header "${header_name}"`

  assertEquals "${message}" "${expected_result}" "${result}"
}

suite_addTest when_printing_a_header_and_no_arguments_are_supplied
suite_addTest when_printing_a_header_and_header_name_argument_is_supplied

when_printing_logging_info_and_all_arguments_are_supplied() {
  local message="It should return info for all properties"
  local scanner="scanner:test:9:9"
  local format="pdf"
  local quality="300"
  local output_name="MyScan"
  local is_preview=false
  local expected_result=`printf "# SCANNER: ${scanner}\n# FORMAT: ${format}\n# QUALITY: ${quality} DPI\n# OUTPUT: ${output_name}\n# PREVIEW: ${is_preview}"`
  
  local result=`print_logging_info "${scanner}" "${format}" "${quality}" "${output_name}" "${is_preview}"`

  assertEquals "${message}" "${expected_result}" "${result}"
}

suite_addTest when_printing_logging_info_and_all_arguments_are_supplied

