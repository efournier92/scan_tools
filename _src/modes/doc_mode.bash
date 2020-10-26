#!/bin/bash

#----------------
# Name          : 
# Description   : 
# Author        : E Fournier
# Dependencies  : scanimage, tiffcp, tiff2pdf, ps2pdf, evince
# Arguments     : 
# Example Usage : 
#----------------

source ./utils/constants.bash
source ./utils/fs.bash
source ./messages/logs.bash
source ./messages/errors.bash

get_create_tiff_dir_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"

  [[ -z "$tiff_dir" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "mkdir -p $tiff_dir"
}

get_scan_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local quality="$2"
  local tiff_dir="$3"
  local tiff_sequence_pattern="$4"

  [[ -z "$scanner" || -z "$quality" || -z "$tiff_dir" || -z "$tiff_sequence_pattern" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "scanimage -d $scanner --batch=$tiff_dir/$tiff_sequence_pattern" --batch-prompt --progress --format=tiff --resolution "$quality"
}

get_merge_tif_files_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"
  local tiff_concat_file="$2"

  [[ -z "$tiff_dir" || -z "$tiff_concat_file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "tiffcp $tiff_dir/*.tif $tiff_dir/$tiff_concat_file"
}

get_convert_tiff_to_pdf_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"
  local tiff_concat_file="$2"
  local pdf_concat_file="$3"

  [[ -z "$tiff_dir" || -z "$tiff_concat_file" || -z "$pdf_concat_file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "tiff2pdf -o $tiff_dir/$pdf_concat_file $tiff_dir/$tiff_concat_file"
}

get_shrink_pdf_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"
  local tiff_concat_file="$2"
  local output_dir="$3"
  local pdf_concat_file="$4"
  local pdf_final_file="$5"

  [[ -z "$tiff_dir" || -z "$tiff_concat_file" || -z $output_dir || -z "$pdf_concat_file" || -z "$pdf_final_file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "ps2pdf $tiff_dir/$pdf_concat_file $output_dir/$pdf_final_file"
}

scan_to_tiff() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local quality="$2"
  local tiff_dir="$3"
  local tiff_sequence_pattern="$4"

  eval `get_create_tiff_dir_command "$tiff_dir"`
  eval `get_scan_command "$scanner" "$quality" "$tiff_dir" "$tiff_sequence_pattern"`
}

print_final_pdf() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"
  local tiff_concat_file="$2"
  local output_dir="$3"
  local pdf_concat_file="$4"
  local pdf_final_file="$5"

  eval `get_merge_tif_files_command "$tiff_dir" "$tiff_concat_file"`
  eval `get_convert_tiff_to_pdf_command "$tiff_dir" "$tiff_concat_file" "$pdf_concat_file"`
  eval `get_shrink_pdf_command "$tiff_dir" "$tiff_concat_file" "$output_dir" "$pdf_concat_file" "$pdf_final_file"`
}

get_show_doc_preview_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local output_dir="$1"
  local pdf_final_file="$2"

  [[ -z "$pdf_final_file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "evince $output_dir/$pdf_final_file"
}

try_preview_scanned_output() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local output_dir="$1"
  local pdf_final_file="$2"

  [[ "$PREVIEW" == "true" ]] && eval `get_show_doc_preview_command "$output_dir" "$pdf_final_file"`
}

get_cleanup_tiff_dir_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"

  [[ -z "$tiff_dir" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "rm -r $tiff_dir"
}

doc_mode() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local quality="$2"
  local output_dir="$3"
  local output_name="$4"

  [[ -z "$scanner" || -z "$quality" || -z "$output_dir" || -z "$output_name" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  local tiff_dir="`config_dir`/`tiff_dir_name`/$output_name"
  local tiff_sequence_pattern=`get_tiff_sequence_pattern "$output_name"`
  local tiff_concat_file=`get_tiff_concat_file "$output_name"`
  local pdf_concat_file=`get_pdf_concat_file "$output_name"`
  local pdf_final_file=`get_pdf_final_file "$output_name"`

  scan_to_tiff "$scanner" "$quality" "$tiff_dir" "$tiff_sequence_pattern"

  print_final_pdf "$tiff_dir" "$tiff_concat_file" "$output_dir" "$pdf_concat_file" "$pdf_final_file"

  try_preview_scanned_output "$output_dir" "$pdf_final_file"

  eval `get_cleanup_tiff_dir_command "$tiff_dir"`
}

