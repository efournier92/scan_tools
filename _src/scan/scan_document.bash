
  ### Print debugging info
  echo "------------------"
  echo "TIFF Directory   : ${temp_tiff_dir}"
  echo "TIFF Concat File : ${temp_tiff_concat_file}"
  echo "TIFF Sequence    : ${tmp_tif_sequence}"
  echo "Output PDF File  : ${output_pdf_file}"
  echo "------------------"

source ./commands/build_scan-document_commands.bash
source ./utils/fs.bash

scan_document() {
  scanner="$1"
  quality="$2"
  output_name="$3"
  is_preview_mode="$4"

  [[ -z "${scanner}" || -z "${quality}" || -z "${output_name}" ]] && exit 1

  ### Configs
  local temp_tiff_dir=`get_temp_tiff_dir`
  local temp_tiff_concat_file=`get_temp_tiff_concat_file "${temp_tiff_dir}"`
  local temp_tiff_sequence=`get_temp_tiff_sequence`"${output_name}%d.tif"
  local output_pdf_file="${output_name}.pdf"
  
  eval `build_create_temp_dir_command`

  eval `build_scanimage_command "${scanner}" "${quality}" "${output_name}" "${is_preview_mode}"`

  eval `build_tiff_cp_command "${temp_tiff_dir}" "${output_name}" "${temp_tiff_concat_file}"`

  eval `build_tiff2pdf_command "${temp_tiff_concat_file}"`

  eval `build_ps2pdf_command "${temp_tiff_concat_file}"`

  eval `build_remove_temp_dir_command`

  [[ ${is_preview_mode} == true ]] && eval `show_preview "${output_pdf_file}"`
}

