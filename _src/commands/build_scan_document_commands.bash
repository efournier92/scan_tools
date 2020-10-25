build_tiff_cp_command() {
  local temp_tiff_dir="$1"
  local sequence_id="$2"
  local temp_tiff_concat_file="$3"

  ### Merge TIF scan files
  tiffcp "${temp_tiff_dir}/${sequence_id}"*.tif "${temp_tiff_concat_file}.tif"
} 

build_tiff2pdf_command() {
  local temp_tiff_concat_file="$1"

  ### Merge TIF scan files
  echo "tiff2pdf -o ${temp_tiff_concat_file}.pdf ${temp_tiff_concat_file}.tif"
}

build_ps2pdf_command() {
  local temp_tiff_concat_file="$1"
  local output_pdf_file="$1"

  echo "ps2pdf ${temp_tiff_concat_file}.pdf ${output_pdf_file}"
}

build_show_preview_command() {
  output_name="$1"

  echo "evince ${1}"
}

build_create_temp_dir_command() {
  local temp_tiff_dir="$1"

  echo `mkdir -p "${temp_tiff_dir}"`
}

build_remove_temp_dir_command() {
  ### Remove temporary scan directory
  rm -r "${temp_tiff_dir}"
}

build_scanimage_command() {
  scanner="$1"
  quality="$2"
  output_name="$3"
  is_preview_mode="$4"

  [[ -z "${scanner}" || -z "${quality}" || -z "${output_name}" || -z "${is_preview_mode}" ]] && exit 1
  
  ### Batch scan PDF scanner
  echo "scanimage -d ${scanner} --batch=${temp_tiff_dir}/${tmp_tif_sequence} --batch-prompt --progress --format=tiff --resolution ${quality}"
}

