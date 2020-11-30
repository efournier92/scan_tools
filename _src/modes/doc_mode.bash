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
  local color_mode="$2"
  local quality="$3"
  local tiff_dir="$4"
  local page_name="$5"

  [[ -z "$scanner" || -z "$quality" || -z "$tiff_dir" || -z "$page_name" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "scanimage -d $scanner --progress --format=tiff --mode $color_mode --resolution $quality -o $tiff_dir/$page_name"
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

batch_scan_to_tiffs() {
  local scanner="$1"
  local color_mode="$2"
  local quality="$3"
  local tiff_dir="$4"
  local page_name="$5"

  local page_number=1
  local should_continue="true"

  until [[ "$should_continue" == "false" ]]; do
    local page_name=`get_tiff_page_name "$page_number"`
    eval `get_scan_command "$scanner" "$color_mode" "$quality" "$tiff_dir" "$page_name"`
    echo "Scanned $tiff_dir/$page_name" >&2

    eval `try_preview_scanned_file "$tiff_dir" "$page_name"`

    read -p "Continue/Preview/Delete/Quit [c/p/d/q] >> " user_input
    if [[ $user_input =~ "q" ]]; then
      local should_continue="false"
    elif [[ $user_input =~ "p" ]]; then
      eval `get_delete_tiff_command "$tiff_dir" "$page_number"`
      eval `get_show_doc_preview_command "$tiff_dir" "$scanned_file"`
      local page_number=$((page_number + 1))
    elif [[ $user_input =~ "d" ]]; then
      eval `get_delete_tiff_command "$tiff_dir" "$page_number"`
    else
      local page_number=$((page_number + 1))
    fi
  done
}

scan_to_tiff() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local color_mode="$2"
  local quality="$3"
  local tiff_dir="$4"

  eval `get_create_tiff_dir_command "$tiff_dir"`
  batch_scan_to_tiffs "$scanner" "$color_mode" "$quality" "$tiff_dir"
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

try_preview_scanned_file() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local output_dir="$1"
  local scanned_file="$2"

  [[ "$PREVIEW" == "true" && -f "$output_dir/$scanned_file" ]] && eval `get_show_doc_preview_command "$output_dir" "$scanned_file"`
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
  local color_mode="$2"
  local quality="$3"
  local output_dir="$4"
  local output_name="$5"

  [[ -z "$scanner" || -z "$quality" || -z "$output_dir" || -z "$output_name" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  local tiff_dir="`config_dir`/`tiff_dir_name`/$output_name"
  local tiff_concat_file=`get_tiff_concat_file "$output_name"`
  local pdf_concat_file=`get_pdf_concat_file "$output_name"`
  local pdf_final_file=`get_pdf_final_file "$output_name"`

  scan_to_tiff "$scanner" "$color_mode" "$quality" "$tiff_dir"

  print_final_pdf "$tiff_dir" "$tiff_concat_file" "$output_dir" "$pdf_concat_file" "$pdf_final_file"

  try_preview_scanned_file "$output_dir" "$pdf_final_file"

  eval `get_cleanup_tiff_dir_command "$tiff_dir"`
}

