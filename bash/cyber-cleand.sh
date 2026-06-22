#!/bin/bash

debugRevert() {
  echo "$1"
  mv $1 .
}

move() {
  dest=$1
  files=("${@:2}")
  mkdir -p "${dest}"
  echo "Debug : ${files[@]}"
  for file in "${files[@]}"; do
    if [[ "${dest}" == "./testTrashFolder/" ]]; then
      target_file="${file%.trash}"
    else
      target_file="${file}"
    fi
    if [[ -e "${dest}${target_file}" ]]; then
      current_time=$(date +%s)
      name="${target_file%.*}"
      ext="${target_file##*.}"
      local new_name="${name}_${current_time}.${ext}"
      mv "${file}" "${dest}${new_name}"
    else
      mv "${file}" "${dest}${target_file}"
    fi
  done

  echo " -------- "
  echo "${dest}"
  ls "${dest}"
  echo "Debug: Reverting back "
  debugRevert "${dest}*" .
}

shopt -s nullglob nocaseglob
pic=(*.png *.jpg *.jpeg *.gif)
doc=(*.txt *.pdf)
trash=(*.trash)
arr=("doc" "pic" "trash")
shopt -u nullglob nocaseglob
pic+=("./testPictureFolder/")
doc+=("./testDocumentFolder/")
trash+=("./testTrashFolder/")
for target in "${arr[@]}"; do
  declare -n curr=$target
  dest="${curr[-1]}"
  echo "Debug : ${curr[-1]}"
  if [[ ${#curr[@]}-1 -ne 0 ]]; then
    files=("${curr[@]:0:${#curr[@]}-1}")
    move "${dest}" "${files[@]}"
  else
    echo "${curr} is emppty -----"
  fi
done
