#!/bin/bash

# gets the config file stuff
source ./config/rules.conf || {
  echo "Error rules.conf not found"
  exit 1
}

# set the search var
search=$1
if [[ -z $search ]]; then
  search="."
fi
echo "$search"
isDebugModeOff=$2
echo $2

# Devs only function
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

# Function to move
# safely

move() {
  local dest="$1"
  shift # shifts the input by 1 so $1 pops and $2 becomes one
  local files=("$@")
  mkdir -p "${dest}"
  echo "Debug : ${files[@]}"
  for file in "${files[@]}"; do
    local filename="${file##*/}"
    if [[ "${dest}" == "./testTrashFolder/" ]]; then # BUG : should't be hardcoded will do it tomorrow
      target_file="${filename%.trash}"
    else
      target_file="${filename}"
    fi

    # I wil have to do the HASH file check
    # so when the file have same content then it skips it

    if [[ -e "${dest}${target_file}" ]]; then # if same folder exist then rename it

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
  # Only for Debug and for me
  if [[ -z "${isDebugModeOff}" ]]; then
    echo "Debug: Reverting back "
    debugRevert "${dest}" .
  fi
}

shopt -s nullglob nocaseglob

for dest in "${!FILE_MAP[@]}"; do
  pattern="${FILE_MAP[$dest]}"
  set -f
  read -ra exts <<<"$pattern"
  set +f

  files_to_move=()
  for ext in "${exts[@]}"; do
    for matched_file in "${search}"/$ext; do
      files_to_move+=("$matched_file")
    done
  done

  if [[ "${#files_to_move[@]}" -gt 0 ]]; then
    move "${dest}" "${files_to_move[@]}"
  fi
done

shopt -u nullglob nocaseglob
