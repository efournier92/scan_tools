#!/bin/bash

#----------------
# Name          : main.bash
# Description   : 
# Author        : E Fournier
# Dependencies  : 
#----------------

source ./args/mode_args.bash
source ./args/verbose_args.bash
source ./args/help_args.bash
source ./args/photo_args.bash
source ./args/document_args.bash
source ./modes/photo_mode.bash
source ./modes/document_mode.bash

run_photo_mode() {
  photo_mode `read_photo_args "$@"`
}

run_document_mode() {
  document_mode `read_document_args "$@"`
}

main() {
  local is_verbose_enabled=`read_verbose_args "$@"`
  [[ "$is_verbose_enabled" == true ]] && VERBOSE=true

  local is_preview_enabled=`read_preview_args "$@"`
  [[ "$is_preview_enabled" == true ]] && PREVIEW=true
  
  local mode=`read_mode_args "$@"`
  read_help_args "$@"
  if [[ "$mode" == `photo_mode_name` ]]; then
    run_photo_mode "$@"
  elif [[ "$mode" == `document_mode_name` ]]; then
    run_document_mode "$@"
  else
    `print_help_by_mode`
  fi
}

main "$@"

