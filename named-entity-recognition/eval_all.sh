#!/bin/bash

DIR=../datasets/NER
mapfile -t DATASETS < <(ls "$DIR")
NER_MODELS=("dmis-lab/biobert-base-cased-v1.1"
 "dmis-lab/biobert-base-cased-v1.2"
 "dmis-lab/biobert-v1.1"
 "dmis-lab/bern2-ner")

# alternative models:
# dmis-lab/biobert-base-cased-v1.2
# dmis-lab/biobert-v1.1
# dmis-lab/bern2-ner
# bert-base-cased

for ner_model in "${NER_MODELS[@]}"; do
  export NER_MODEL="$ner_model"
      for ds in "${DATASETS[@]}"; do
        echo "+++Model: $ner_model"
        echo "+Dataset: $ds"
        export DATASET="$ds"
        bash train.sh
      done
done
