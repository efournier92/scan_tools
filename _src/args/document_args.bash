#!/bin/bash

#----------------
# Name          : document_args.bash
# Description   : Interprets command arguments for document mode
#----------------

source ./input/user_select.bash
source ./utils/constants.bash
source ./utils/fs.bash
source ./utils/time.bash
source ./messages/logs.bash
source ./messages/errors.bash

read_document_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local i=0
  while [ "$1" != "" ]; do
    case $1 in
      -i | --scanner )
        shift
        local scanner="$1"
        ;;

      -q | --quality )
        shift
        local codec="$1"
        ;;

      -d | --output_dir )
        shift
        local output_dir="$1"
        ;;

      -o | --output_name )
        shift
        local output_name="$1"
        ;;

    esac
    shift
  done

  [[ -z "$scanner" ]] && local scanner=`get_scanner`
  [[ -z "$quality" ]] && local quality=`default_document_quality`
  [[ -z "$output_dir" ]] && local output_dir=`default_output_dir`
  [[ -z "$output_name" ]] && local output_dir=`default_document_file_name`

  echo "$scanner" "$quality" "$output_dir" "$output_location"
}

