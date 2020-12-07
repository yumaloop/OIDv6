# -------------------
# Duck (/m/09ddx)
# -------------------

# duck test
egrep /m/09ddx csv/full/test-annotations-bbox.csv | cut -d ',' -f1 > csv/duck-test-images-ids.txt 

# duck validation
egrep /m/09ddx csv/full/validation-annotations-bbox.csv | cut -d ',' -f1 > csv/duck-validation-images-ids.txt 

# duck train
egrep /m/09ddx csv/full/train-annotations-bbox.csv | cut -d ',' -f1 > csv/duck-train-images-ids.txt 


# -------------------
# Rabbit (/m/06mf6)
# -------------------

# test rabbit
egrep /m/06mf6 csv/full/test-annotations-bbox.csv | cut -d ',' -f1 > csv/rabbit-test-images-ids.txt 

# validation rabbit
egrep /m/06mf6 csv/full/validation-annotations-bbox.csv | cut -d ',' -f1 > csv/rabbit-validation-images-ids.txt 

# train rabbit
egrep /m/06mf6 csv/full/train-annotations-bbox.csv | cut -d ',' -f1 > csv/rabbit-train-images-ids.txt 
