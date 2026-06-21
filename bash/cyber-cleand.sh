#!/bin/bash

debugRevert() {
  mv ./testPictureFolder/*.png ./testPictureFolder/*.jpg ./
}

move() {
  dest=$1
  files=("${@:2}")
  echo "Debug : ${files[@]}"
  mv "${files[@]}" "${dest}"
  echo " -------- "
  echo "${dest}"
  ls "${dest}"
  echo "Debug: Reverting back "
  debugRevert
}

shopt -s nullglob
pic=(*.png *.jpg)
doc=(*.txt *.png)
arr=("doc" "pic")
shopt -u nullglob
for target in "${arr[@]}"; do
  declare -n curr=$target
done
if [[ ${#pic[@]} -ne 0 ]]; then
  # move "./testPictureFolder/" "${pic[@]}"
  echo ""
fi

# debugRevert
