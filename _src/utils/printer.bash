default_line_length(){
  echo 16
}

default_line_char(){
  echo "_"
}

default_header_name(){
  echo "???"
}

print_line() {
  local line_length="${1}"
  local line_char="${2}"
  [[ -z "${line_length}" ]] && line_length=`default_line_length`
  [[ -z "${line_char}" ]] && line_char=`default_line_char`
  
  local sbuild=""
  for i in `seq ${line_length}`; do
    sbuild="${sbuild}${line_char}"
  done

  echo "${sbuild}\n"
}

print_header() {
  local header_name
  [[ -z "$1" ]] && header_name=`default_header_name` || header_name="$1"

  local line_length="${#header_name}"
  
  echo "$(print_line ${line_length})${header_name}:\n"
}

### Print debugging info
print_logging_info() {
  local scanner="$1"
  local format="$2"
  local quality="$3"
  local output_name="$4"
  local is_preview="$5"
  
  local output=""
  output="${output}# SCANNER: ${scanner}\n"
  output="${output}# FORMAT: ${format}\n"
  output="${output}# QUALITY: ${quality} DPI\n"
  output="${output}# OUTPUT: ${output_name}\n"
  output="${output}# PREVIEW: ${is_preview}\n"

  printf "${output}"
}

