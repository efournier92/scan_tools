### Evaluate supplied arguments to override presets
get_presets() {
  local i=0
  while [ "$1" != "" ]; do
    case $1 in
      -s | --scanner )
        shift
        local scanner="${1}"
        ;;

      -f | --format )
        shift
        local format="${1}"
        ;;

      -q | --quality )
        shift
        local quality="${1}"
        ;;

      -p | --preview_mode )
        local is_preview_mode=true
        ;;

      -v | --verbose )
        local is_verbose_mode=true
        ;;

      -o | --output_name )
        shift
        local output_name="${1}"
        ;;

      -h | --help )
        usage
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

  echo "${scanner} ${format} ${quality} ${output_name} ${is_preview_mode}"
}

