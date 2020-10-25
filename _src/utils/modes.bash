#!/bin/bash

#----------------
# Name          : modes.bash
# Description   : Utility functions for mode detection
#----------------

source ./utils/constants.bash
source ./messages/errors.bash

is_mode_known() {
  local selected_mode="$1"

  [[ -z "$selected_mode" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  local known_modes=(`photo_mode_name` `doc_mode_name` `crop_mode_name`)
  
  local is_known=false
  for mode in "${known_modes[@]}"; do
    [[ "$selected_mode" == "$mode" ]] && is_known=true
  done
  
  echo "$is_known"
}

