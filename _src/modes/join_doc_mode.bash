#!/bin/bash

#----------------
# Name          : join_doc_mode.bash
# Project       : scanz
# Description   : Run process join a directory of jpegs to a pdf
#----------------

get_file_names() {
  local jpeg_dir="$1"

  file_names=""
  for file in $jpeg_dir/*.jpg; do
    file_names="${file_names} ${file}"
  done

  echo "$file_names"
} 

get_join_doc_command() {
  local jpeg_dir="$1"

  [[ -z "$jpeg_dir" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"
  
  local file_names=`get_file_names "$jpeg_dir"`
  
  echo "convert $file_names $jpeg_dir.pdf"
}

run_join_doc_command() {
  local command="$1"

  eval "$command"
}

join_doc_mode() {
  local join_doc_command=`get_join_doc_command "$@"`

  run_join_doc_command "$join_doc_command"
}

