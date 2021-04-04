#!/bin/bash

#----------------
# Name          : crop_mode.bash
# Project       : scanz
# Description   : Functions to facilitate crop-mode functionality
#----------------

create_jpegs_from_pdf() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
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
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local image_directory="$1"

  file_names=""
  for file in $image_directory/*.jpg; do
    file_names="${file_names} ${file}"
    gimp "$file"
  done

  echo "$file_names"
} 

print_cropped_pdf() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local file_names="$1"
  local pdf_name="$2"

  convert "${file_names:1}" "$pdf_name"
}

crop_all_jpegs() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local jpeg_dir="$1"
  local pdf_dir="$2"

  for image_directory in $jpeg_dir/*; do
    pdf_name="$pdf_dir/${image_directory##*/}.pdf"

    [[ -f "$pdf_name" ]] && continue
    
    local doc_file_names=`crop_jpegs_in_pdf_dir "$image_directory"`

    print_cropped_pdf "$doc_file_names" "$pdf_name"
  done
}

crop_mode() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local input_dir="$1"
  local jpeg_dir=`crop_jpeg_dir`
  local pdf_dir=`crop_pdf_dir`

  create_jpegs_from_pdf "$pdf_dir"
  crop_all_jpegs "$jpeg_dir" "$pdf_dir"
}

