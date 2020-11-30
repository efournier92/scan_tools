#!/bin/bash

#----------------
# Name          : 
# Description   : 
# Author        : E Fournier
# Dependencies  : 
# Arguments     : 
# Example Usage : 
#----------------

create_jpegs_from_pdf() {
  local pdf_dir="$1"

  mkdir -p "$pdf_dir"

  for file in *.pdf; do
    local dir_name="${file%.*}"
    local output_path="$jpeg_dir/$dir_name"

    mkdir -p "$output_path"

    [[ "$(ls -A $output_path)" ]] && continue

    pdftoppm -jpeg -r 300 "$file" "$jpeg_dir/$dir_name/pg"
  done
}

crop_jpegs_in_pdf_dir() {
  file_names=""
  for file in $image_directory/*.jpg; do
    file_names="${file_names} ${file}"
    gimp "$file"
  done

  echo "$file_names"
} 

print_cropped_pdf() {
  local file_names="$1"
  local pdf_name="$2"

  convert "$file_names" "$pdf_name.pdf"
}

crop_all_jpegs() {
  local jpeg_dir="$"
  local pdf_dir="$"
  local image_directory="$"

  for image_directory in $jpeg_dir/*; do
    pdf_name="$pdf_dir/${image_directory##*/}.pdf"

    [[ -f "$pdf_name" ]] && continue
    
    doc_file_names=`crop_jpegs_in_pdf_dir`

    print_cropped_pdf "$file_names" "$pdf_name"
  done
}

crop_mode() {
  local input_dir="$1"
  local jpeg_dir=`crop_jpeg_dir`
  local pdf_dir=`crop_pdf_dir`

  create_jpegs_from_pdf 
  crop_all_jpegs
}

