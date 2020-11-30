#!/bin/bash

source ./utils/time.bash

doc_mode_name() {
  echo "doc"
}

photo_mode_name() {
  echo "photo"
}

crop_mode_name() {
  echo "crop"
}

split_doc_mode_name() {
  echo "split_doc"
}

color_mode_color() {
  echo "Color"
}

color_mode_bw() {
  echo "Gray"
}

default_color_mode() {
  echo `color_mode_color`
}

default_photo_format() {
  echo "jpeg"
}

default_photo_quality() {
  echo "600"
}

default_doc_quality() {
  echo "300"
}

selectable_formats() {
  echo "pdf jpeg"
}

selectable_qualities() {
  echo "600 300 150 75"
}

crop_jpeg_dir() {
  echo "_JPEGs"
}

crop_pdf_dir() {
  echo "_PDFs"
}

