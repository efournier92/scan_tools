#!/bin/bash

source ./utils/constants.bash
source ./messages/logs.bash
source ./messages/errors.bash

get_scan_photo_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local format="$2"
  local quality="$3"
  local output_location="$4"

  [[ -z "$scanner" || -z "$format" || -z "$quality" || -z "$output_location" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "scanimage -d $scanner --progress --format=$format --resolution $quality -o $output_location"
}

photo_mode() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local format="$2"
  local quality="$3"
  local output_dir="$4"
  local output_name="$5"
  local output_location="$output_dir/$output_name.jpeg"

  [[ -z "$scanner" || -z "$format" || -z "$quality" || -z "$output_dir" || -z "$output_name" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"
  
  eval `get_scan_photo_command "$scanner" "$format" "$quality" "$output_location"`
}

