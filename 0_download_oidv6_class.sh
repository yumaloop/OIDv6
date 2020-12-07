# Download the classes description
wget https://storage.googleapis.com/openimages/v5/class-descriptions-boxable.csv -O csv/full/class-descriptions-boxable.csv

# Downlad the label_map.pbtxt
wget https://raw.githubusercontent.com/tensorflow/models/master/research/object_detection/data/oid_bbox_trainable_label_map.pbtxt -O csv/oid_bbox_trainable_label_map.pbtxt 
