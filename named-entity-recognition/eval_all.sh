#!/bin/bash

DIR=../datasets/NER
DATASETS=$(ls -1 "$DIR")

for ds in $DATASETS; do
  s="$ds"
  export ENTITY="$s"
  bash train.sh
done
