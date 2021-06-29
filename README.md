# OIDv6

How to download the image data related to the chosen classes from Google Open-Images-Dataset (version 6).

- [How to Download a Subset of Open Image Dataset v6 (on ubuntu using the shell) - Medium.com](https://medium.com/@nicolas.windt/how-to-download-a-subset-of-open-image-dataset-v6-on-ubuntu-using-the-shell-c55336e33b03)
- [cvdfoundation/open-images-dataset](https://github.com/cvdfoundation/open-images-dataset#download-full-dataset-with-google-storage-transfer)


### Preparation

Install csvtool in Ubuntu

```
sudo apt-get install csvtool
```

Install csvtool in macOS

```
brew install opam
opam init
opam install csv
sudo ln -s ~/.opam/system/bin/csvtool /usr/local/bin/
csvtool --help # check if csvtool is downloaded
csvtool --version # check if csvtools is downloaded
```

Create new directories.

```
mkdir csv
mkdir csv/full
```

### Procedure

##### 0. Download the class information

```
# Download the classes description
wget https://storage.googleapis.com/openimages/v5/class-descriptions-boxable.csv -O csv/full/class-descriptions-boxable.csv

# Downlad the label_map.pbtxt
wget https://raw.githubusercontent.com/tensorflow/models/master/research/object_detection/data/oid_bbox_trainable_label_map.pbtxt -O csv/oid_bbox_trainable_label_map.pbtxt
```

```
# Gather the suitable class name
egrep Duck csv/full/class-descriptions-boxable.csv | head -n 1 | csvtool col 1 -
```

see `csv/full/class-descriptions-boxable.csv`

```
/m/09ddx,Duck
/m/06mf6,Rabbit
```

##### 1. Download all bounding boxes annotations (full search)

```
# test annotations (bbox) 73.89M
wget https://storage.googleapis.com/openimages/v5/test-annotations-bbox.csv -O csv/full/test-annotations-bbox.csv

# validation annotations (bbox) 23.94M
wget https://storage.googleapis.com/openimages/v5/validation-annotations-bbox.csv -O csv/full/validation-annotations-bbox.csv

# train annotations (bbox) 2.10G
wget https://storage.googleapis.com/openimages/v6/oidv6-train-annotations-bbox.csv -O csv/full/train-annotations-bbox.csv

```

##### 2. Download all image urls (full search)

```
# test (43.13M )
wget https://storage.googleapis.com/openimages/2018_04/test/test-images-with-rotation.csv -O csv/full/test-images-with-rotation.csv

# validation (14.54M)
wget https://storage.googleapis.com/openimages/2018_04/validation/validation-images-with-rotation.csv -O csv/full/validation-images-with-rotation.csv

# train (608.83M)
wget https://storage.googleapis.com/openimages/2018_04/train/train-images-boxable-with-rotation.csv -O csv/full/train-images-boxable-with-rotation.csv
```

##### 3. Filter the annotations (image ids) related to the chosen class

```
# duck test
egrep /m/09ddx csv/full/test-annotations-bbox.csv | cut -d ',' -f1 > csv/duck-test-images-ids.txt

# duck validation
egrep /m/09ddx csv/full/validation-annotations-bbox.csv | cut -d ',' -f1 > csv/duck-validation-images-ids.txt

# duck train
egrep /m/09ddx csv/full/train-annotations-bbox.csv | cut -d ',' -f1 > csv/duck-train-images-ids.txt
```


##### 4. Filter the image urls corresponding to the selected class (e.g. `Duck` & `Rabbit`)

```
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

```

