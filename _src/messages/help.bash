#!/bin/bash

#----------------
# Name          : help.bash
# Description   : Library of functions for printing help info
#----------------

help_header() {
cat << EOF
----------
SCAN TOOLS
EOF
}

help_general() {
cat << EOF
_______
GENERAL

  -h, --help [mode]    print help information [for mode]

  -m, --mode           enable mode [capture|cut|batch|join]

  -v, --verbose        enable verbose debugging info

  -p, --preview        enable preview after scan
  
  USAGE: scan_tools -m capture -h -v -p

EOF
}

help_photo() {
cat << EOF
_____
PHOTO

  -i, --scanner        scanner device for input

  -f, --format         format for scan

  -q, --quality        scan qualiter [150, 300, 600]

  -d, --output_dir     directory in which to save the capture

  -o, --output_name    name for the scanned file

  USAGE: scan_tools -m photo -i scanner -q 600 -f jpeg -d . -o scan

EOF
}

help_document() {
cat << EOF
________
DOCUMENT

  -i, --scanner        scanner device for input

  -q, --quality        scan qualiter [150, 300, 600]

  -d, --output_dir     directory in which to save the capture

  -o, --output_name    name for the scanned file
  
  USAGE: scan_tools -m document -i scanner -q 300 -d . -o scan

EOF
}

print_help_photo() {
  help_header
  help_photo
}

print_help_document() {
  help_header
  help_document
}

print_help_all() {
  help_header
  help_general
  help_photo
  help_document
}

print_help_by_mode() {
  local mode="$1"
  
  if [[ "$mode" == `photo_mode_name` ]]; then
    print_help_photo
  elif [[ "$mode" == `document_mode_name` ]]; then
    print_help_document
  else
    print_help_all
  fi
}

show_help() {
  local mode="$1"
  
  echo `print_help_by_mode "$mode"`

  exit
}

