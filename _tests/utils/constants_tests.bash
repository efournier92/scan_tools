#!/bin/bash

#----------------
# Name          : constants_tests.bash
# Project       : scanz
# Description   : Unit tests for application constants
#----------------

source "./_src/utils/constants.bash"

test_doc_mode_name() {
  local message="It should return the default doc-mode name."
  local expected_result="doc"

  local result=`doc_mode_name`

  assertEquals "$message" "$expected_result" "$result"
}

test_photo_mode_name() {
  local message="It should return the default photo-mode name."
  local expected_result="photo"

  local result=`photo_mode_name`

  assertEquals "$message" "$expected_result" "$result"
}

test_crop_mode_name() {
  local message="It should return the default crop-mode name."
  local expected_result="crop"

  local result=`crop_mode_name`

  assertEquals "$message" "$expected_result" "$result"
}

test_split_doc_mode_name() {
  local message="It should return the default split-doc-mode name."
  local expected_result="split_doc"

  local result=`split_doc_mode_name`

  assertEquals "$message" "$expected_result" "$result"
}

test_join_doc_mode_name() {
  local message="It should return the default join-doc-mode name."
  local expected_result="join_doc"

  local result=`join_doc_mode_name`

  assertEquals "$message" "$expected_result" "$result"
}

test_color_mode_name() {
  local message="It should return the color-mode name."
  local expected_result="color"

  local result=`color_mode_color`

  assertEquals "$message" "$expected_result" "$result"
}

test_gray_mode_name() {
  local message="It should return the gray-mode name."
  local expected_result="gray"

  local result=`color_mode_gray`

  assertEquals "$message" "$expected_result" "$result"
}

test_default_color_mode_name() {
  local message="It should return the color-mode name."
  local expected_result=`color_mode_color`

  local result=`default_color_mode`

  assertEquals "$message" "$expected_result" "$result"
}

test_default_photo_format() {
  local message="It should return the default photo format."
  local expected_result="jpeg"

  local result=`default_photo_format`

  assertEquals "$message" "$expected_result" "$result"
}

test_default_photo_quality() {
  local message="It should return the default photo quality."
  local expected_result="600"

  local result=`default_photo_quality`

  assertEquals "$message" "$expected_result" "$result"
}

test_default_doc_quality() {
  local message="It should return the default doc quality."
  local expected_result="300"

  local result=`default_doc_quality`

  assertEquals "$message" "$expected_result" "$result"
}

test_selectable_formats() {
  local message="It should return all selectable formats."
  local expected_result="pdf jpeg"

  local result=`selectable_formats`

  assertEquals "$message" "$expected_result" "$result"
}

test_selectable_formats() {
  local message="It should return all selectable formats."
  local expected_result="pdf jpeg"

  local result=`selectable_formats`

  assertEquals "$message" "$expected_result" "$result"
}

test_selectable_qualities() {
  local message="It should return all selectable qualities."
  local expected_result="600 300 150 75"

  local result=`selectable_qualities`

  assertEquals "$message" "$expected_result" "$result"
}

test_crop_jpeg_dir() {
  local message="It should return the name of the crop-jpeg directory."
  local expected_result="_JPEGs"

  local result=`crop_jpeg_dir`

  assertEquals "$message" "$expected_result" "$result"
}

test_crop_pdf_dir() {
  local message="It should return the name of the crop-jpeg directory."
  local expected_result="_PDFs"

  local result=`crop_pdf_dir`

  assertEquals "$message" "$expected_result" "$result"
}

. ./bin/shunit2

