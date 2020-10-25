#!/bin/bash

#----------------
# Name          : 
# Description   : 
# Author        : E Fournier
# Dependencies  : 
# Arguments     : 
# Example Usage : 
#----------------

source ./utils/printer.bash
source ./constants/constants.bash

user_select_scanner() {
  scanner="$1"

  printf "$(print_header 'SELECT SCANNER')" >&2
  select selected_scanner in `scanimage -f "%d %n"`; do
    scanner="$selected_scanner"
    break
  done

  echo "$scanner"
}

