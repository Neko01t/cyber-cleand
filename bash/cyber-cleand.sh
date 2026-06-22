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
  if [[ "${dest}" == "./testTrashFolder/" ]]; then
    for file in "${files[@]}"; do
      mv "${file}" "${dest}${file%.trash}"
    done

  else
    mv "${files[@]}" "${dest}"
    echo " -------- "
    echo "${dest}"
  fi
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

# debugRevert
