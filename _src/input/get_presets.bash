source ./utils/time.bash
source ./constants/print_usage.bash
source ./input/select.bash

### Evaluate supplied arguments to override presets
get_presets() {
  local i=0
  local scanner
  local format
  local quality
  local is_preview=false
  local is_verbose=false
  while [ "$1" != "" ]; do
    case $1 in
      -s | --scanner )
        shift
        scanner="${1}"
        ;;

      -f | --format )
        shift
        format="${1}"
        ;;

      -q | --quality )
        shift
        quality="${1}"
        ;;

      -p | --preview )
        is_preview=true
        ;;

      -v | --verbose )
        is_verbose=true
        ;;

      -o | --output_name )
        shift
        output_name="${1}"
        ;;

      -h | --help )
        print_usage
        exit
        ;;

      * )
        #usage
        ;;

    esac
    shift
  done

  [[ -z "${scanner}" ]] && scanner=`user_select_scanner`
  [[ -z "${format}" ]] && format=`user_select_format`
  [[ -z "${quality}" ]] && quality=`user_select_quality`
  [[ -z "${output_name}" ]] && output_name=`get_time_now`

  echo "${scanner} ${format} ${quality} ${output_name} ${is_preview} ${is_verbose}"
}

