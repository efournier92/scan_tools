#!/bin/bash

source ./utils/time.bash
source ./constants/constants.bash
source ./messages/logs.bash
source ./messages/errors.bash

get_scan_photo_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local format="$2"
  local quality="$3"
  local output_location="$4"

  echo "scanimage -d $scanner --progress --format=$format --resolution $quality -o $output_location"
}

run_scan_photo_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local command="$1"
  
  eval "$command"
}

photo_mode() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local format="$2"
  local quality="$3"
  local output_location="$4"

  local scan_command=`build_scan_photo_command "$scanner" "$format" "$quality" "$output_location"`

 run_scan_photo_command "$scan_command" 
}

