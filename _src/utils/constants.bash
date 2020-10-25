#!/bin/bash

source ./utils/time.bash

document_mode_name() {
  echo "capture"
}

photo_mode_name() {
  echo "capture"
}

default_photo_format() {
  echo "jpeg"
}

default_photo_quality() {
  echo "600"
}

default_document_quality() {
  echo "300"
}


selectable_formats() {
  echo "pdf jpeg"
}

selectable_qualities() {
  echo "600 300 150 75"
}

photo_mode_name() {
  echo "photo"
}

photo_formats() {
  echo "jpeg"
}

document_mode_name() {
  echo "document"
}

document_formats() { 
  echo "pdf" 
}

message_image_mode_not_detected() {
  echo "ERROR: Image mode not detected. Exiting."
}

message_scanner_not_supplied() {
  echo "ERROR: Scanner was not supplied. Exiting."
}

# fs

default_output_dir() {
  echo "$(pwd)"
}

temp_tiff_dir_name() {
  echo "_temp_tiff"
}

default_photo_file_name() {
  echo "`get_time_now`.jpeg"
}

default_document_file_name() {
  echo "`get_time_now`.pdf"
}

