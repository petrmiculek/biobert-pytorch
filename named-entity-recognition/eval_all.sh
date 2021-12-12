#!/bin/bash

DIR=../datasets/NER
#DATASETS=($(ls "$DIR"))
mapfile -t DATASETS < <(ls "$DIR")
MODELS=("dmis-lab/biobert-base-cased-v1.1")
# "dmis-lab/biobert-base-cased-v1.2"
# "dmis-lab/biobert-v1.1")

# alternative models:
# dmis-lab/biobert-base-cased-v1.2
# dmis-lab/biobert-v1.1
# dmis-lab/bern2-ner

for model in "${MODELS[@]}"; do
  echo "+++Model: $model"
  export NER_MODEL="$model"
      for ds in "${DATASETS[@]}"; do
        echo "+Dataset: $ds"
        export ENTITY="$ds"
        bash train.sh
      done
done
