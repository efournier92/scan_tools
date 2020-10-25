
source ./constants/constants.bash

## Image Mode
detect_image_mode() {
  scan_format="$1"

  if [[ $scan_format == "jpeg" ]]; then
    echo `photo_mode_name`
  elif [[ $scan_format == "pdf" ]]; then
    echo `document_mode_name`
  else
    echo `message_image_mode_not_detected`
  fi
}

