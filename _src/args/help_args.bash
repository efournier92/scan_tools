#!/bin/bash

#----------------
# Name          : help_args.bash
# Description   : Reads command arguments requesting help info
#----------------

source ./messages/logs.bash
source ./messages/errors.bash
source ./messages/help.bash

read_help_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  while [ "$1" != "" ]; do
    case $1 in
      -h | --help )
        local should_show_help=true
        ;;

    esac
    shift
  done
 
  if [[ "$should_show_help" == true ]]; then
    print_help_by_mode "$mode"
    exit
  fi
}


