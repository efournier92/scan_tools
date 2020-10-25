#!/bin/bash

source ./input/get_presets.bash

mock_scanner() {
  echo "scanner:brand:9:9"
}

mock_format() {
  echo "pdf"
}

mock_quality() {
  echo "300"
}

mock_time() {
  echo "20-09-13_153204"
}

setUp() {
  get_time_now() {
    echo `mock_time`
  }

  user_select_scanner() { 
    echo `mock_scanner`
  }

  user_select_format() { 
    echo `mock_format`
  }

  user_select_quality() { 
    echo `mock_quality`
  }
}

when_command_has_no_arguments() {
  local message="It should return the default list of configuration values"
  local expected_result="`mock_scanner` `mock_format` `mock_quality` `mock_time` false false"

  local result=`get_presets`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_shortform_scanner_argument() {

  local message="It should return the default list of configuration values"
  local scanner="test:specific:scanner:9:9"
  local expected_result="${scanner} `mock_format` `mock_quality` `mock_time` false false"

  local result=`get_presets -s ${scanner}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_longform_scanner_argument() {
  local message="It should return the default list of configuration values"
  local scanner="test:specific:scanner:9:9"
  local expected_result="${scanner} `mock_format` `mock_quality` `mock_time` false false"

  local result=`get_presets --scanner ${scanner}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_shortform_format_argument() {
  local message="It should "
  local format="jpeg"
  local expected_result="`mock_scanner` ${format} `mock_quality` `mock_time` false false"

  local result=`get_presets -f ${format}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_longform_format_argument() {
  local message="It should "
  local format="jpeg"
  local expected_result="`mock_scanner` ${format} `mock_quality` `mock_time` false false"

  local result=`get_presets --format ${format}`

  assertEquals "${message}" "${expected_result}" "${result}"
}


when_command_has_shortform_quality_argument() {
  local message="It should "
  local quality="999"
  local expected_result="`mock_scanner` `mock_format` ${quality} `mock_time` false false"

  local result=`get_presets -q ${quality}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_longform_quality_argument() {
  local message="It should "
  local quality="999"
  local expected_result="`mock_scanner` `mock_format` ${quality} `mock_time` false false"

  local result=`get_presets --quality ${quality}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_shortform_output_name_argument() {
  local message="It should "
  local output_name="TestScan"
  local expected_result="`mock_scanner` `mock_format` `mock_quality` ${output_name} false false"

  local result=`get_presets -o ${output_name}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_longform_output_name_argument() {
  local message="It should "
  local output_name="TestScan"
  local expected_result="`mock_scanner` `mock_format` `mock_quality` ${output_name} false false"

  local result=`get_presets -o ${output_name}`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_shortform_preview_argument() {
  local message="It should "
  local expected_result="`mock_scanner` `mock_format` `mock_quality` `mock_time` true false"

  local result=`get_presets -p`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_longform_preview_argument() {
  local message="It should "
  local expected_result="`mock_scanner` `mock_format` `mock_quality` `mock_time` true false"

  local result=`get_presets --preview`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_shortform_verbose_argument() {
  local message="It should "
  local expected_result="`mock_scanner` `mock_format` `mock_quality` `mock_time` false true"

  local result=`get_presets -v`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_longform_verbose_argument() {
  local message="It should "
  local expected_result="`mock_scanner` `mock_format` `mock_quality` `mock_time` false true"

  local result=`get_presets --verbose`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_shortform_help_argument() {
  local message="It should "
  local expected_result="USAGE"

  local result=`get_presets -h`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_longform_help_argument() {
  local message="It should "
  local expected_result="USAGE"

  local result=`get_presets --help`

  assertEquals "${message}" "${expected_result}" "${result}"
}


when_command_has_all_shortform_config_arguments() {
  local message="It should "
  local scanner="test:specific:scanner:9:9"
  local format="jpeg"
  local quality="999"
  local output_name="TestScan"
  local expected_result="${scanner} ${format} ${quality} ${output_name} true true"

  local result=`get_presets -s ${scanner} -f ${format} -q ${quality} -p -v`

  assertEquals "${message}" "${expected_result}" "${result}"
}

when_command_has_all_longform_config_arguments() {
  local message="It should "
  local scanner="test:specific:scanner:9:9"
  local format="jpeg"
  local quality="999"
  local output_name="TestScan"
  local expected_result="${scanner} ${format} ${quality} ${output_name} true true"

  local result=`get_presets --scanner ${scanner} --format ${format} --quality ${quality} --preview --verbose`

  assertEquals "${message}" "${expected_result}" "${result}"
}

suite_addTest when_command_has_no_arguments
suite_addTest when_command_has_shortform_scanner_argument
suite_addTest when_command_has_longform_scanner_argument
suite_addTest when_command_has_shortform_format_argument
suite_addTest when_command_has_longform_format_argument
suite_addTest when_command_has_shortform_quality_argument
suite_addTest when_command_has_longform_quality_argument
suite_addTest when_command_has_shortform_preview_argument
suite_addTest when_command_has_longform_preview_argument
suite_addTest when_command_has_shortform_verbose_argument
suite_addTest when_command_has_longform_verbose_argument
suite_addTest when_command_has_shortform_help_argument
suite_addTest when_command_has_longform_help_argument
suite_addTest when_command_has_all_shortform_config_arguments
suite_addTest when_command_has_all_longform_config_arguments

