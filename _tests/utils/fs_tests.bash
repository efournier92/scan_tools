#!/bin/bash

#----------------
# Name          : fs_tests.bash
# Project       : scanz
# Description   : Unit tests for file-system functions
#----------------

source "./_src/utils/fs.bash"
source "./_src/utils/time.bash"

test_default_output_dir() {
  local message="It should return the default output directory name."
  local output_name="$(pwd)"
  local expected_result=`default_output_dir`

  local result=`default_output_dir`

  assertEquals "$message" "$expected_result" "$result"
}

test_default_config_dir() {
  local message="It should return the config directory name."
  local expected_result="$HOME/.scanz"

  local result=`config_dir`

  assertEquals "$message" "$expected_result" "$result"
}

test_default_file_name() {
  local message="It should return the default file name."
  local expected_result="`get_time_now`"

  local result=`default_file_name`

  assertEquals "$message" "$expected_result" "$result"
}

test_tiff_dir_name() {
  local message="It should return the tiff directory name."
  local expected_result="_TIFs"

  local result=`tiff_dir_name`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_tiff_page_name() {
  local message="It should return the name of the tiff page with the supplied page number."
  local expected_result="page_009.tif"

  local result=`get_tiff_page_name "9"`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_tiff_concat_file() {
  local message="It should return the name of the tiff concat file based on the supplied output name."
  local expected_result="_concat_test.tif"

  local result=`get_tiff_concat_file "test"`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_pdf_concat_file() {
  local message="It should return the name of the pdf concat file based on the supplied output name."
  local expected_result="_concat_test.pdf"

  local result=`get_pdf_concat_file "test"`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_final_pdf_file() {
  local message="It should return the name of the final pdf file based on the supplied output name."
  local expected_result="test.pdf"

  local result=`get_pdf_final_file "test"`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

