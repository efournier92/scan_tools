#!/bin/bash

#----------------
# Name          : read_preview_arg.bash
# Description   : 
#----------------

source ./messages/logs.bash
source ./messages/errors.bash
source ./utils/modes.bash

read_preview_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  while [ "$1" != "" ]; do
    case $1 in
      -p | --preview )
        local is_preview_enabled="true"
        ;;

    esac
    shift
  done
 
  [[ -z "$preview" ]] && local is_preview_enabled="false"

  echo "$preview"
}


