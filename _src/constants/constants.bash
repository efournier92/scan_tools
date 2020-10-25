#!/bin/bash

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

