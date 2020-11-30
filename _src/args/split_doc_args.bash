#!/bin/bash

#----------------
# Name          : doc_args.bash
# Description   : Interprets command arguments for doc mode
#----------------

source "./input/user_select.bash"
source "./messages/help.bash"
source "./utils/constants.bash"

read_split_doc_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local i=0

  while [ "$1" != "" ]; do
    case $1 in
      -i | --doc | --pdf )
        shift
        local pdf_file="$1"
        ;;

      -d | --jpeg_dir )
        shift
        local jpeg_dir="$1"
        ;;

    esac
    shift
  done

  echo "$pdf_file" "$jpeg_dir"
}

