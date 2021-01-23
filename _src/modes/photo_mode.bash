#!/bin/bash

#----------------
# Name          : photo_mode.bash
# Project       : scanz
# Description   : Run scan process for photos
#----------------

source "./_src/utils/constants.bash"
source "./_src/messages/logs.bash"
source "./_src/messages/errors.bash"

get_scan_photo_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local color_mode="$2"
  local quality="$3"
  local output_location="$4"

  [[ -z "$scanner" || -z "$color_mode" || -z "$quality" || -z "$output_location" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "scanimage -d $scanner --progress --format=png --mode $color_mode --resolution $quality -o $output_location"
}

photo_mode() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local color_mode="$2"
  local quality="$3"
  local output_dir="$4"
  local output_name="$5"

  local output_location="$output_dir/$output_name.png"

  [[ -z "$scanner" || -z "$color_mode" || -z "$quality" || -z "$output_dir" || -z "$output_name" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"
  
  eval `get_scan_photo_command "$scanner" "$color_mode" "$quality" "$output_location"`
}

