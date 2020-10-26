#!/bin/bash

source ./utils/modes.bash
source ./constants/constants.bash

when_detecting_image_mode_and_format_is_pdf() {
  local message="It should"
  local format="pdf"
  local expected_result=`document_mode_name`

  local result=`detect_image_mode ${format}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_detecting_image_mode_and_format_is_jpeg() {
  local message="It should"
  local format="jpeg"
  local expected_result=`photo_mode_name`

  local result=`detect_image_mode ${format}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_detecting_image_mode_and_unrecognized_format_is_supplied() {
  local message="It should"
  local format="lol"
  local expected_result=`message_image_mode_not_detected`

  local result=`detect_image_mode ${format}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_detecting_image_mode_and_no_arguments_are_supplied() {
  local message="It should"
  local expected_result=`message_image_mode_not_detected`

  local result=`detect_image_mode`

  assertEquals "${message}" "${expected_result}" "${result}"
}

suite_addTest when_detecting_image_mode_and_format_is_pdf
suite_addTest when_detecting_image_mode_and_format_is_jpeg
suite_addTest when_detecting_image_mode_and_unrecognized_format_is_supplied
suite_addTest when_detecting_image_mode_and_no_arguments_are_supplied

