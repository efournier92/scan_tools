#!/bin/bash

#----------------
# Name          : doc_args.bash
# Description   : Interprets command arguments for doc mode
#----------------

source "./_src/input/user_select.bash"
source "./_src/utils/constants.bash"
source "./_src/utils/fs.bash"
source "./_src/utils/time.bash"
source "./_src/messages/logs.bash"
source "./_src/messages/errors.bash"

read_doc_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"

  while [[ "$1" != "" ]]; do
    case $1 in

      -i | --scanner )
        shift
        local scanner="$1"
        ;;

      -q | --quality )
        shift
        local quality="$1"
        ;;

      -d | --output_dir )
        shift
        local output_dir="$1"
        ;;

      -o | --output_name )
        shift
        local output_name="$1"
        ;;

      -g | --grayscale )
        local bw_color_mode="true"
        ;;

    esac
    shift
  done
  
  [[ -z "$scanner" ]] && local scanner=`user_select_scanner`
  [[ -z "$quality" ]] && local quality=`default_doc_quality`
  [[ -z "$output_dir" ]] && local output_dir=`default_output_dir`
  [[ -z "$output_name" ]] && local output_name=`default_file_name`
  [[ "$bw_color_mode" = "true" ]] \
    && local color_mode=`color_mode_gray` \
    || local color_mode=`color_mode_color`

  echo "$scanner" "$color_mode" "$quality" "$output_dir" "$output_name"
}

