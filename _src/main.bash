#!/bin/bash

#----------------
# Name          : main.bash
# Description   : 
# Author        : E Fournier
# Dependencies  : 
#----------------

source ./args/mode_args.bash
source ./args/help_args.bash

main() {
  local is_verbose=`read_verbose_args "$@"`
  [[ "$is_verbose" == true ]] && VERBOSE=true
  
  create_config_dir

  local mode=`read_mode_args "$@"`
  read_help_args "$@"
  if [[ "$mode" == `document_mode_name` ]]; then
    run_document_mode "$@"
  elif [[ "$mode" == `cut_mode_name` ]]; then
    run_photo_mode "$@"
  else
    `print_help_by_mode`
  fi
}

main "$@"

