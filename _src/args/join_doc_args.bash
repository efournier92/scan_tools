#!/bin/bash

#----------------
# Name          : doc_args.bash
# Description   : Interprets command arguments for doc mode
#----------------

source "./input/user_select.bash"
source "./messages/help.bash"
source "./utils/constants.bash"

read_join_doc_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local i=0

  while [ "$1" != "" ]; do
    case $1 in

      -i | -d | --jpeg_dir )
        shift
        local jpeg_dir="$1"
        ;;

    esac
    shift
  done

  echo "$jpeg_dir"
}

