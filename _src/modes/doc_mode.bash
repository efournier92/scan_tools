#!/bin/bash

#----------------
# Name          : doc_mode.bash
# Project       : scanz
# Description   : Run scan process for documents
#----------------

source "./_src/utils/constants.bash"
source "./_src/utils/fs.bash"
source "./_src/messages/logs.bash"
source "./_src/messages/errors.bash"

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

  [[ -z "$scanner" || -z "$color_mode" || -z "$quality" || -z "$tiff_dir" || -z "$page_name" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "scanimage -d $scanner --progress --format=tiff --mode $color_mode --resolution $quality -o $tiff_dir/$page_name"
}

get_merge_tif_files_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"
  local tiff_concat_file="$2"

  [[ -z "$tiff_dir" || -z "$tiff_concat_file" ]] \
    && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "tiffcp $tiff_dir/*.tif $tiff_dir/$tiff_concat_file"
}

get_convert_tiff_to_pdf_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"
  local tiff_concat_file="$2"
  local pdf_concat_file="$3"

  [[ -z "$tiff_dir" || -z "$tiff_concat_file" || -z "$pdf_concat_file" ]] \
    && error_missing_function_args "${FUNCNAME[0]}" "$@"

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

get_batch_message() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local page_number="$1"

  if [[ $page_number -le 0 ]]; then
    local message="\nStart [enter] >> "
  else
    local message="\n\nContinue/Preview/Delete/Quit [c/p/d/q] >> "
  fi

  echo "$message"
}

on_batch_quit() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local page_number="stop"

  echo $page_number
}

on_batch_preview() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"
  local page_number="$2"

  local page_name=`get_tiff_page_name $page_number`

  eval `get_show_doc_preview_command "$tiff_dir" "$page_name"`

  echo $page_number
}

on_batch_delete() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local tiff_dir="$1"
  local page_number=$2

  local page_name=`get_tiff_page_name $page_number`

  eval `get_delete_tiff_command "$tiff_dir" "$page_name"`
  local page_number=$(( page_number - 1 ))

  echo $page_number
}

print_output() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local message="$1"

  printf "$message" >&2
}

on_batch_scan() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local color_mode="$2"
  local quality="$3"
  local tiff_dir="$4"
  local page_number="$5"
  
  page_number=$(( page_number + 1 ))
  local page_name=`get_tiff_page_name $page_number`

  print_output "Scanning $tiff_dir/$page_name\n"
  eval `get_scan_command "$scanner" "$color_mode" "$quality" "$tiff_dir" "$page_name"`

  echo $page_number
}

get_batch_user_input() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local message="$1"

  print_output "$message"
  read user_input

  echo "$user_input"
}

run_batch_next_step() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local color_mode="$2"
  local quality="$3"
  local tiff_dir="$4"
  local page_number="$5"
  
  [[ -z $page_number || $page_number -lt 0 ]] && local page_number=0
  local message=`get_batch_message $page_number`
  
  local user_input=`get_batch_user_input "$message"`

  local page_name=`get_tiff_page_name $page_number`
  if [[ $user_input =~ "q" ]]; then
    local page_number=`on_batch_quit`
  elif [[ $user_input =~ "p" ]]; then
    local page_number=`on_batch_preview "$tiff_dir" "$page_number"`
  elif [[ $user_input =~ "d" ]]; then
    local page_number=`on_batch_delete "$tiff_dir" "$page_number"`
  else
    local page_number=`on_batch_scan "$scanner" "$color_mode" "$quality" "$tiff_dir" "$page_number"`
  fi

  echo $page_number
}

batch_scan_to_tiffs() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local scanner="$1"
  local color_mode="$2"
  local quality="$3"
  local tiff_dir="$4"

  until [[ "$page_number" == "stop" ]]; do
    local page_number=`run_batch_next_step "$scanner" "$color_mode" "$quality" "$tiff_dir" $page_number`
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
  local file="$2"

  [[ -z "$output_dir" || -z "$file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "evince $output_dir/$file &> /dev/null"
}

get_delete_tiff_command() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local output_dir="$1"
  local file="$2"

  [[ -z "$output_dir" || -z "$file" ]] && error_missing_function_args "${FUNCNAME[0]}" "$@"

  echo "rm $output_dir/$file"
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

