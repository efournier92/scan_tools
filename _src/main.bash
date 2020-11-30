#!/bin/bash

#----------------
# Name          : main.bash
# Description   : 
# Author        : E Fournier
# Dependencies  : 
#----------------

source ./messages/help.bash
source ./utils/constants.bash
source ./args/mode_args.bash
source ./args/verbose_args.bash
source ./args/preview_args.bash
source ./args/help_args.bash
source ./args/photo_args.bash
source ./args/doc_args.bash
source ./args/split_doc_args.bash
source ./modes/photo_mode.bash
source ./modes/doc_mode.bash
source ./modes/split_doc_mode.bash

run_photo_mode() {
  photo_mode `read_photo_args "$@"`
}

run_doc_mode() {
  doc_mode `read_doc_args "$@"`
}

run_crop_mode() {
  crop_mode `read_crop_args "$@"`
}

run_split_doc_mode() {
  split_doc_mode `read_split_doc_args "$@"`
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
  elif [[ "$mode" == `doc_mode_name` ]]; then
    run_doc_mode "$@"
  elif [[ "$mode" == `crop_mode_name` ]]; then
    run_crop_mode "$@"
  elif [[ "$mode" == `split_doc_mode_name` ]]; then
    run_split_doc_mode "$@"
  else
    print_help_by_mode "$mode"
  fi
}

main "$@"

