#!/bin/bash

#----------------
# Name          : 
# Description   : 
# Author        : E Fournier
# Dependencies  : 
# Arguments     : 
# Example Usage : 
#----------------

split_doc_mode() {
  local pdf_file="$1"
  local jpeg_dir="$2"

  [[ -z "$pdf_file" || -z "$jpeg_dir" || ! -f $pdf_file ]] && error_pdf_file_not_found "$pdf_file"

  local jpeg_dir="${pdf_file%%.*}"
  mkdir -p "./$jpeg_dir"

  pdftoppm -jpeg -r 300 "$pdf_file" "$jpeg_dir/pg"
}

