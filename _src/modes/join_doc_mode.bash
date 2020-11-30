#!/bin/bash

#----------------
# Name          : 
# Description   : 
# Author        : E Fournier
# Dependencies  : 
# Arguments     : 
# Example Usage : 
#----------------

get_file_names() {
  local jpeg_dir="$1"

  file_names=""
  for file in $jpeg_dir/*.jpg; do
    file_names="${file_names} ${file}"
  done

  echo "$file_names"
} 

join_doc_mode() {
  local jpeg_dir="$1"

  [[ -z "$jpeg_dir" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"
  
  local file_names=`get_file_names "$jpeg_dir"`
  
  convert "$file_names" "$jpeg_dir.pdf"
}

