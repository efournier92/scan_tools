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

config_dir() {
  echo "$HOME/.scanz"
}

default_file_name() {
  echo "`get_time_now`"
}

tiff_dir_name() {
  echo "_TIFs"
}

get_tiff_sequence_pattern() {
  local output_name="$1"
  
  echo "$output_name_%d.tif"
}

get_tiff_concat_file() {
  local output_name="$1"
  
  echo "_concat_$output_name.tif"
}

get_pdf_concat_file() {
  local output_name="$1"
  
  echo "_concat_$output_name.pdf"
}

get_pdf_final_file() {
  local output_name="$1"
  
  echo "$output_name.pdf"
}

