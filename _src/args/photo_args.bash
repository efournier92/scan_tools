#!/bin/bash

#----------------
# Name          : photo_args.bash
# Description   : Interprets command arguments for photo mode
#----------------

read_photo_args() {
  [[ "$VERBOSE" = true ]] && log_arguments "${FUNCNAME[0]}" "$@"
  local i=0
  while [ "$1" != "" ]; do
    case $1 in
      -i | --scanner )
        shift
        local scanner="$1"
        ;;

      -f | --format )
        shift
        local format="$1"
        ;;

      -q | --quality )
        shift
        local quality="$1"
        ;;

      -d | --output_dir )
        shift
        local output_dir="$1"
        ;;

      -o | --output_name )
        shift
        local output_name="$1"
        ;;

    esac
    shift
  done

  [[ -z "$scanner" ]] && local scanner=`get_scanner_selection`
  [[ -z "$format" ]] && local format=`default_photo_format`
  [[ -z "$quality" ]] && local quality=`default_photo_quality`
  [[ -z "$output_dir" ]] && local output_dir=`default_output_dir`
  [[ -z "$output_name" ]] && local output_name=`default_photo_file_name`
  
  local output_location="$output_dir/$output_name"

  echo "$audio_device" "$input_format" "$output_format" "$channels" "$sample_rate" "$max_threads" "$stop_time" "$output_location"
}

