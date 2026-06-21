#!/bin/bash

debugRevert() {
  echo "$1"
  mv $1 .
}

move() {
  dest=$1
  files=("${@:2}")
  unset 'files[-1]'
  echo "Debug : ${files[@]}"
  mv "${files[@]}" "${dest}"
  echo " -------- "
  echo "${dest}"
  ls "${dest}"
  echo "Debug: Reverting back "
  debugRevert "${dest}*" .
}

shopt -s nullglob
pic=(*.png *.jpg)
doc=(*.txt *.pdf)
arr=("doc" "pic")
shopt -u nullglob
pic+=("./testPictureFolder/")
doc+=("./testDocumentFolder/")

for target in "${arr[@]}"; do
  declare -n curr=$target
  dest="${curr[-1]}"
  echo "Debug : ${curr[-1]}"
  files=("${curr[@]:0:${#curr[@]}-1}")
  move "${dest}" "${files[@]}"
done
if [[ ${#pic[@]} -ne 0 ]]; then
  # move "./testPictureFolder/" "${pic[@]}"
  echo ""
fi

# debugRevert
