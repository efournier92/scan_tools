#!/bin/bash

#----------------
# Name          : split_doc_mode.bash
# Project       : scanz
# Description   : Run process to split a pdf into a directory of jpegs
#----------------

source "./_src/messages/errors.bash"

get_jpeg_dir() {
  local pdf_file="$1"

  echo "${pdf_file%%.*}"
}

create_jpeg_dir() {
  local pdf_file="$1"

  local jpeg_dir=`get_jpeg_dir "$pdf_file"`

  mkdir -p "$(pwd)/$jpeg_dir"
}

get_split_doc_command() {
  local pdf_file="$1"

  [[ -z "$pdf_file" ]] && error_missing_function_args "${FUNCNAME[0]} $@"

  [[ ! -f $pdf_file ]] && error_pdf_file_not_found "$pdf_file"

  local jpeg_dir=`get_jpeg_dir "$pdf_file"`

  echo "pdftoppm -jpeg -r 300 $pdf_file $jpeg_dir/pg"
}

run_split_doc_command() {
  local command="$1"

  eval "$command"
}

split_doc_mode() {
  local pdf_file="$1"
  local command=`get_split_doc_command $@`

  create_jpeg_dir "$pdf_file"

  run_split_doc_command "$command"  
}

