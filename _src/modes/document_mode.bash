#!/bin/bash

#----------------
# Name          : 
# Description   : 
# Author        : E Fournier
# Dependencies  : 
# Arguments     : 
# Example Usage : 
#----------------

source ./utils/constants.bash
source ./messages/logs.bash
source ./messages/errors.bash

get_temp_tiff_dir_location() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local output_dir="$1"

  [[ -z "$output_dir" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "$output_dir/`temp_tiff_dir_name`"
}

get_create_temp_dir_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local temp_dir_location="$1"

  [[ -z "$temp_dir_location" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  mkdir -p "$temp_dir_location"
}

get_scan_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local quality="$2"
  local temp_tiff_sequence_location="$3"

  [[ -z "$scanner" || -z "$quality" || -z "$temp_tiff_sequence_location" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "scanimage -d $scanner --batch=$temp_tiff_dir/$tmp_tif_sequence" --batch-prompt --progress --format=tiff --resolution "$quality"
}

get_merge_tif_files_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local temp_tiff_sequence_location="$1"
  local temp_tiff_concat_file="$2"

  [[ -z "$temp_tiff_sequence_location" || -z "$temp_tiff_concat_file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "tiffcp $temp_tiff_sequence_location/*.tif $temp_tiff_concat_file"
}

get_convert_tiff_concat_to_pdf_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local temp_tiff_concat_file="$1"

  [[ -z "$temp_tiff_concat_file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "tiff2pdf -o $temp_tiff_concat_file.pdf $temp_tiff_concat_file.tif"
}

get_standardize_pdf_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local temp_tiff_concat_file="$1"
  local output_pdf_file="$2"

  [[ -z "$temp_tiff_concat_file" || -z "$output_pdf_file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "ps2pdf $temp_tiff_concat_file.pdf $output_pdf_file"
}

get_show_document_preview_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local output_pdf_file="$1"

  [[ -z "$output_pdf_file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "evince $output_pdf_file"
}

get_remove_temp_dir_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local temp_dir_location="$1"

  [[ -z "$temp_dir_location" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo rm -r "$temp_tiff_dir"
}

document_mode() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local quality="$2"
  local output_dir="$3"
  local output_name="$4"

  [[ -z "$scanner" || -z "$quality" || -z "$output_dir" || -z "$output_name" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  local temp_dir_location=`get_temp_tiff_dir_location "$output_dir"`
  local temp_tiff_sequence_location="$temp_dir_location/`temp_tiff_dir_name`"
  local temp_tiff_concat_file="$temp_tiff_dir/out_concat"
  local output_pdf_file="$output_name.pdf"

  eval `get_create_temp_dir_command "$temp_dir_location"`
  eval `get_scan_command "$scanner" "$quality" "$temp_tiff_sequence_location"`
  eval `get_merge_tif_files_command "$temp_tiff_sequence_location" "$temp_tiff_concat_file"`
  eval `get_convert_tiff_concat_to_pdf_command "$temp_tiff_concat_file"`
  eval `get_standardize_pdf_command "$temp_tiff_concat_file" "$output_pdf_file"`

  eval `get_remove_temp_dir_command "$temp_dir_location"`

  [[ "$PREVIEW" == "true" ]] && eval `get_show_document_preview_command "$output_pdf_file"`
}

