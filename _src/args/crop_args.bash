#!/bin/bash

#----------------
# Name          : doc_args.bash
# Description   : Interprets command arguments for doc mode
#----------------

read_crop_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local i=0
  while [ "$1" != "" ]; do
    case $1 in
      -i | --input_dir )
        shift
        local input_dir="$1"
        ;;

    esac
    shift
  done

  [[ -z "$input_dir" ]] && local input_dir=`default_input_dir`

  echo "$input_dir"
}

