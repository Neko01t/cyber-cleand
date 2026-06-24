#!/bin/bash

source ./config/rules.conf || {
  echo "Error rules.conf not found"
  exit 1
}

search=$1
if [[ -z $search ]]; then
  search="."
fi
echo "$search"
isDebugModeOff=$2
echo $2
debugRevert() {
  echo "$1"
  echo "${2}"

  for file in "${1}"*; do
    [[ -e "${file}" ]] || continue
    if [[ "${1}" == "./testTrashFolder/" ]]; then
      basename="${file##*/}"
      mv "${file}" "${2}/${basename}.trash"
    else
      mv "${file}" "${2}/"
    fi
  done
}

move() {
  local dest="$1"
  local files=("${@:2}")
  mkdir -p "${dest}"
  echo "Debug : ${files[@]}"
  for file in "${files[@]}"; do
    if [[ "${dest}" == "./testTrashFolder/" ]]; then
      target_file="${file%.trash}"
    else
      target_file="${file}"
    fi
    if [[ -e "${dest}${target_file}" ]]; then
      local current_time="$(date +%s)"
      local name="${target_file%.*}"
      local ext="${target_file##*.}"
      local new_name="${name}_${current_time}.${ext}"
      mv "${file}" "${dest}${new_name}"
    else
      mv "${file}" "${dest}${target_file}"
    fi
  done

  echo " -------- "
  echo "${dest}"
  ls "${dest}"
  if [[ -z "${isDebugModeOff}" ]]; then
    echo "Debug: Reverting back "
    debugRevert "${dest}" .
  fi
}

shopt -s nullglob nocaseglob
for dest in "${!FILE_MAP[@]}"; do
  pattern="${FILE_MAP[$dest]}"
  file=($pattern)
  if [[ "${#file[@]}" -gt 0 ]]; then
    move "${dest}" "${file[@]}"
  fi
done
shopt -u nullglob nocaseglob
