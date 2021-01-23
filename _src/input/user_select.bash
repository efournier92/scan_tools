#!/bin/bash

#----------------
# Name          : user_select.bash
# Project       : scanz
# Description   : Collect user input via select menus
#----------------

source "./_src/utils/constants.bash"

user_select_scanner() {
  scanner="$1"

  #printf "$(print_header 'SELECT SCANNER')" >&2
  select selected_scanner in `scanimage -f "%d %n"`; do
    scanner="$selected_scanner"
    break
  done

  echo "$scanner"
}

user_select_pdf_file() {
  read -p "PDF File: " pdf_file

  echo "$pdf_file"
}

