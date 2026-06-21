#!/bin/bash

debugRevert() {
  mv ./testPictureFolder/*.png ./testPictureFolder/*.jpg ./
}

ls=(*)
shopt -s nullglob
pic=(*.png *.jpg)
doc=(*.txt *png)
shop -u nullglob
if [[ ${#pic[@]} -ne 0 ]]; then
  echo "Debug : ${pic[@]}"
  mv ${pic[@]} ./testPictureFolder/
  echo " -------- "
  echo "./testPictureFolder/"
  ls ./testPictureFolder/
  echo " -------- "
  echo "Debug: Reverting back "
  debugRevert
fi

# debugRevert
