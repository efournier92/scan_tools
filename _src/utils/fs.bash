#!/bin/bash

#----------------
# Name          : 
# Description   : 
# Author        : E Fournier
# Dependencies  : 
# Arguments     : 
# Example Usage : 
#----------------

source ./utils/time.bash

default_output_dir() {
  echo "$(pwd)"
}

temp_tiff_dir_name() {
  echo "_temp_tiff"
}

default_photo_file_name() {
  echo "`get_time_now`.jpeg"
}

default_doc_file_name() {
  echo "`get_time_now`.pdf"
}

get_temp_tiff_dir() {
  local output_name="$1"
  
  echo "scan_$output_name"
}

get_temp_tiff_concat_file() {
  local temp_sequence_name="$1"
  
  echo "$temp_tiff_dir/out_concat"
}

get_temp_tiff_sequence(){
  local output_name="$1"
  
  echo "$output_name%d.tif"
}

get_output_pdf_file(){
  local output_name="$1"
  
  echo "$output_name.pdf"
}
  
