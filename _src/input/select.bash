
source ./utils/printer.bash
source ./constants/constants.bash

### Ensure required arguments are valid

#### Select from available scanners
user_select_scanner() {
  scanner="${1}"

  printf "$(print_header 'SELECT SCANNER')" >&2
  select selected_scanner in `scanimage -f "%d %n"`; do
    scanner="${selected_scanner}"
    break
  done

  echo "${scanner}"
}

#### Select output format
user_select_format() {
  local format="$1"

  if [[ "${format}" != "jpeg" && "${format}" != "pdf" ]]; then
    printf "$(print_header 'SELECT FORMAT')" >&2
    select selected_format in `selectable_formats`; do
      format="${selected_format}"
      break
    done
  fi

  echo "${format}"
}

#### Select output quality in DPI
user_select_quality() {
  local quality="$1"

  if [[ -z "${quality}" ]]; then
    printf "$(print_header 'SELECT QUALITY (DPI)')" >&2
    select selected_quality in `selectable_qualities`; do
      quality="${selected_quality}"
      break
    done
  fi

  echo "$quality"
}

