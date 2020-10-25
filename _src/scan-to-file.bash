#!/bin/zsh

#---------------
# Name         : scan-to-file.bash
# Description  : Scans and converts image inputs to a file
# Author       : E Fournier
# Dependencies : scanimage, ps2pdf, tiffcp, tiff2pdf, ps2pdf, evince
# Arguments    : -s ${scanner} -f ${scan_format} -n ${output_name} -q ${quality} -p ${is_preview_mode}
# Sample Usage : bash scan-to-file -s ${} -f pdf -n scan -q 300 -p
#---------------

source ./input/get_presets.bash
source ./utils/printer.bash
source ./utils/modes.bash
source ./scan/scan_photo.bash
source ./scan/scan_document.bash

## Configuration

### Presets
output_name=$(date '+%y-%m-%d_%H%M%S')

main() {
  local args=(`get_presets "$@"`)
  local scanner="${args[0]}"
  local format="${args[1]}"
  local quality="${args[2]}"
  local output_name="${args[3]}"
  local is_preview_mode="${args[4]}"
  local is_verbose_mode="${args[5]}"
 
  #[[ is_verbose_mode == true ]] && 
  print_logging_info "${scanner}" "${format}" "${quality}" "${output_name}" "${is_preview_mode}"

  local image_mode=`detect_image_mode ${format}`
  if [[ "${image_mode}" == `photo_mode_name` ]]; then
    scan_photo "${scanner}" "${format}" "${quality}" "${output_name}"
  elif [[ "${image_mode}" == `document_mode_name` ]]; then
    scan_document "${scanner}" "${quality}" "${output_name}" "${is_preview_mode}"
  else
    echo "Mode not detected. Nothing scanned."
  fi 
}

main "$@"

