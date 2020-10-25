#!/bin/bash

#----------------
# Name          : help.bash
# Description   : Library of functions for printing help info
#----------------

help_header() {
cat << EOF
----
VHSD | VHS Digitizer
----
EOF
}

help_general() {
cat << EOF
_______
GENERAL

  -h, --help [mode]    print help information [for mode]

  -m, --mode           enable mode [capture|cut|batch|join]

  -v, --verbose        enable verbose debugging info
  
  USAGE: vhsd -m capture -h -v

EOF
}

help_capture() {
cat << EOF
_______
CAPTURE

  -i, --input,         input video devide
  --video_device

  -a, --audio_device   input audio device

  -c, --codec          output video codec

  -t, --stop_time      maximum capture duration

  -d, --output_dir     directory in which to save the capture

  -o, --output_name    name for the capture file

  --video_format       output video format []

  --audio_format       output audio format []

  --crf                output constant rate factor

  --preset             preset for capture process []

  --size               input video size

  --standard           input stream standard [ntsc,pal,...]

  --threads            maximum threads for process

  --tune               tuning for capture output [film,...]

  USAGE: vhsd -m capture -i /dev/video0 -a hw:2,0 -d . -o captured.bash

EOF
}

help_cut() {
cat << EOF
___
CUT

  -i, --input_file     input video for cutting

  -d, --output_dir     directory in which to save the cut file

  -o, --output_name    name for the cut file
  
  --crf                constant rate factor for encoding cut file

  --crop               crop to apply in cut file

  --dimensions         dimensions of the output cut file

  --preset             preset for the encoding process

  --queue_size         max queue size for encoding process

  --tune               video tuning for the output file [film,...]
  
  USAGE: vhsd -m cut -i file.mp4 -d . -o cut.mp4

EOF
}

help_batch() {
cat << EOF
_____
BATCH

  -i, --input,         
  --batch_file         batch text file created from cut mode
  
  USAGE: vhsd -m batch -i ~/.vhsd/batch.txt

EOF
}

help_join() {
cat << EOF
____
JOIN

  -i, --input,         batch text file created in cut mode


  -d, --output_dir     directory in which to save the joined file

  -o, --output_name    name for the joined file

  USAGE: vhsd -m join -i file.mp4 -d . -o out_file.mp4

EOF
}

help_watch() {
cat << EOF
_____
WATCH

  -i, --input,         input video devide
  --video_device

  USAGE: vhsd -m watch -i /dev/video0

EOF
}

print_help_capture() {
  help_header
  help_capture
}

print_help_cut() {
  help_header
  help_cut
}

print_help_batch() {
  help_header
  help_batch
}

print_help_join() {
  help_header
  help_join
}

print_help_watch() {
  help_header
  help_watch
}

print_help_all() {
  help_header
  help_general
  help_capture
  help_cut
  help_batch
  help_join
  help_watch
}

print_help_by_mode() {
  local mode="$1"
  
  if [[ "$mode" == `capture_mode_name` ]]; then
    print_help_capture
  elif [[ "$mode" == `cut_mode_name` ]]; then
    print_help_cut
  elif [[ "$mode" == `batch_mode_name` ]]; then
    print_help_batch
  elif [[ "$mode" == `join_mode_name` ]]; then
    print_help_join
  elif [[ "$mode" == `watch_mode_name` ]]; then
    print_help_watch
  else
    print_help_all
  fi
}

show_help() {
  local mode="$1"
  
  echo `print_help_by_mode "$mode"`

  exit
}

