#!/bin/bash

for class in "duck" "rabbit" 
do
  for subset in "test" "validation" "train"
  do
    rm -f csv/${class}-${subset}-images-urls.csv
    touch csv/${class}-${subset}-images-urls.csv
    sort csv/${class}-${subset}-images-ids.txt | uniq > csv/input.txt
    echo $subset

    # read each line (image-id)
    while read p; do
      echo $p
      LC_ALL=C grep -i ${p} csv/full/${subset}-images-with-rotation.csv | csvtool -c 1,3 >> csv/${class}-${subset}-images-urls.csv
    done < csv/input.txt

  done
done
