#!/bin/bash

export SAVE_DIR=./output
export DATA_DIR=datasets/NER

export MAX_LENGTH=192
export BATCH_SIZE=8
export NUM_EPOCHS=10
export SAVE_STEPS=1000
#export DATASET=NCBI-disease  # passed from outside as a env variable
export SEED=1

#CODE_DIR=/storage/brno3-cerit/home/petrmiculek/biobert-pytorch/named-entity-recognition
#NER_MODEL=dmis-lab/biobert-base-cased-v1.1
#DATASET=linnaeus
DATA_DIR="${CODE_DIR}/${DATA_DIR}"

mkdir -p "${SAVE_DIR}/${DATASET}/${NER_MODEL}"

echo "train.sh: `pwd`/${SAVE_DIR}/${DATASET}/${NER_MODEL}"

# the variable name is not an error, it is exported from job.sh -> eval_all.sh
# python "$CODE_DIR/scripts/value_error.py"
python3 "${CODE_DIR}/named-entity-recognition/run_ner.py" \
    --data_dir "${DATA_DIR}/${DATASET}"/ \
    --labels "${DATA_DIR}/${DATASET}/labels.txt" \
    --model_name_or_path "${NER_MODEL}" \
    --output_dir "${SAVE_DIR}/${DATASET}/${NER_MODEL}" \
    --max_seq_length ${MAX_LENGTH} \
    --num_train_epochs ${NUM_EPOCHS} \
    --per_device_train_batch_size ${BATCH_SIZE} \
    --save_steps ${SAVE_STEPS} \
    --seed ${SEED} \
    --do_train \
    --do_predict \
    --do_eval \
    --overwrite_output_dir \
    |& tee -a "${SAVE_DIR}/${DATASET}/${NER_MODEL}/stdout.txt"
