#!/bin/bash

#----------------
# Name          : doc_mode_tests.bash
# Project       : scanz
# Description   : Unit tests for doc-mode functionality
#----------------

source "./_src/modes/doc_mode.bash"

test_get_scan_command_with_missing_args() {
  local message="It should throw a missing-function-args error."
  local expected_result=`error_missing_function_args "get_scan_command" "$@"`

  local result=`get_scan_command`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_scan_command_with_all_args() {
  local message="It should return a scanimage command with all configured values."
  local test_scanner="test_scanner_0"
  local test_color_mode="gray"
  local test_quality="999"
  local test_tiff_dir="/home/me/tiff"
  local test_page_name="page9"
  local expected_result="scanimage -d $test_scanner --progress --format=tiff --mode $test_color_mode --resolution $test_quality -o $test_tiff_dir/$test_page_name"

  local result=`get_scan_command "$test_scanner" "$test_color_mode" "$test_quality" "$test_tiff_dir" "$test_page_name"`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_merge_tif_files_command_with_missing_args() {
  local message="It should throw a missing-function-args error."
  local expected_result=`error_missing_function_args "get_merge_tif_files_command" "$@"`

  local result=`get_merge_tif_files_command`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_merge_tif_files_command_with_all_args() {
  local message="It should return a tiffcp command with all configured values."
  local test_tiff_dir="/home/me/tiff"
  local test_tiff_concat_file="TestTiff"
  local expected_result="tiffcp $test_tiff_dir/*.tif $test_tiff_dir/$test_tiff_concat_file"

  local result=`get_merge_tif_files_command "$test_tiff_dir" "$test_tiff_concat_file"`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_convert_tiff_to_pdf_command_with_missing_args() {
  local message="It should throw a missing-function-args error."
  local expected_result=`error_missing_function_args "get_convert_tiff_to_pdf_command" "$@"`

  local result=`get_convert_tiff_to_pdf_command`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_merge_tif_files_command_with_all_args() {
  local message="It should return a tiff2pdf command with all configured values."
  local test_tiff_dir="/home/me/tiff"
  local test_tiff_concat_file="_tiff_concat"
  local test_pdf_concat_file="_pdf_concat"
  local expected_result="tiff2pdf -o $test_tiff_dir/$test_pdf_concat_file $test_tiff_dir/$test_tiff_concat_file"

  local result=`get_convert_tiff_to_pdf_command "$test_tiff_dir" "$test_tiff_concat_file" "$test_pdf_concat_file"`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_shrink_pdf_command_with_missing_args() {
  local message="It should throw a missing-function-args error."
  local expected_result=`error_missing_function_args "get_shrink_pdf_command" "$@"`

  local result=`get_shrink_pdf_command`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_shrink_pdf_command_with_all_args() {
  local message="It should return a ps2pdf command with all configured values."
  local test_tiff_dir="/home/me/tiff"
  local test_tiff_concat_file="_tiff_concat"
  local test_output_dir="/home/me/out"
  local test_pdf_concat_file="_pdf_concat"
  local test_pdf_final_file="_pdf_final"
  local expected_result="ps2pdf $test_tiff_dir/$test_pdf_concat_file $test_output_dir/$test_pdf_final_file"

  local result=`get_shrink_pdf_command "$test_tiff_dir" "$test_tiff_concat_file" "$test_output_dir" "$test_pdf_concat_file" "$test_pdf_final_file"`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_show_doc_preview_command_with_missing_args() {
  local message="It should throw a missing-function-args error."
  local expected_result=`error_missing_function_args "get_show_doc_preview_command" "$@"`

  local result=`get_show_doc_preview_command`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_show_doc_preview_command_with_all_args() {
  local message="It should return an evince command to open the doc by configured arguments."
  local test_output_dir="/home/me/out"
  local test_pdf_final_file="FinalPdf"
  local expected_result="evince $test_output_dir/$test_pdf_final_file &> /dev/null"

  local result=`get_show_doc_preview_command "$test_output_dir" "$test_pdf_final_file"`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_cleanup_tiff_dir_command_with_missing_args() {
  local message="It should throw a missing-function-args error."
  local expected_result=`error_missing_function_args "get_cleanup_tiff_dir_command" "$@"`

  local result=`get_cleanup_tiff_dir_command`

  assertEquals "$message" "$expected_result" "$result"
}

test_get_cleanup_tiff_dir_command_with_all_args() {
  local message="It should return an rm command for the configured directory."
  local test_tiff_dir="/home/me/tiff"
  local expected_result="rm -r $test_tiff_dir"

  local result=`get_cleanup_tiff_dir_command "$test_tiff_dir"`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

