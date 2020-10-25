#!/bin/bash

source ./utils/time.bash
source ./constants/constants.bash

scan_photo() {
  local scanner="$1"
  local format="$2"
  local quality="$3"
  local output_name="$4"

  eval `build_scan_photo_command ${scanner} ${format} ${quality} ${output_name}`
}

scan_doc() {
  build_scan_doc_command
}

on_scanner_not_supplied() {
  echo `message_scanner_not_supplied`
  exit 1
}

build_scan_photo_command() {
  local scanner="$1"
  local format="$2"
  local quality="$3"
  local output_name="$4"

  [[ -z "${scanner}" ]] && on_scanner_not_supplied
  [[ -z "${format}" ]] && on_format_not_supplied
  [[ -z "${quality}" ]] && on_quality_not_supplied
  [[ -z "${output_name}" ]] && output_name=`get_time_now`

  echo "scanimage -d ${scanner} --progress --format=${format} --resolution ${quality} -o ${output_name}.jpeg"
}

build_scan_document_command() {
  local scanner="$1"
  local format="$2"
  local quality="$3"
  local output_name="$4"
  
  echo ""
}


