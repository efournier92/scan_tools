exit_with_error() {
  local message="$1"

  echo "${message}"
  exit 1
}

missing_arguments_error() {
  local function_name="$1"

  echo "ERROR: Required argument(s) missing from ${function_name}"
}

get_temp_tiff_dir() {
  local output_name="$1"
  
  [[ -z "${output_name}" ]] && exit_with_error "`missing_arguments_error get_temp_tiff_dir`"

  echo "scan_${output_name}"
}

get_temp_tiff_concat_file() {
  local temp_sequence_name="$1"
  
  [[ -z "${temp_sequence_name}" ]] && exit 1

  echo "${temp_tiff_dir}/out_concat"
}

get_temp_tiff_sequence(){
  local output_name="$1"
  
  [[ -z "${output_name}" ]] && exit 1

  echo "${output_name}%d.tif"
}

get_output_pdf_file(){
  local output_name="$1"
  
  [[ -z "${output_name}" ]] && exit 1

  echo "${output_pdf}.pdf"
}
  
