#!/bin/bash

export SAVE_DIR=./output
export DATA_DIR=../datasets/NER

export MAX_LENGTH=192
export BATCH_SIZE=32
export NUM_EPOCHS=1
export SAVE_STEPS=1000
#export DATASET=NCBI-disease  # passed from outside as a env variable
export SEED=1

mkdir -p "${SAVE_DIR}"/"${DATASET}"
mkdir -p "${SAVE_DIR}"/"${DATASET}"/"${NER_MODEL}"

echo "${SAVE_DIR}"/"${DATASET}"/"${NER_MODEL}"

python run_ner.py \
    --data_dir ${DATA_DIR}/"${DATASET}"/ \
    --labels ${DATA_DIR}/"${DATASET}"/labels.txt \
    --model_name_or_path "${NER_MODEL}" \
    --output_dir ${SAVE_DIR}/"${DATASET}"/"${NER_MODEL}" \
    --max_seq_length ${MAX_LENGTH} \
    --num_train_epochs ${NUM_EPOCHS} \
    --per_device_train_batch_size ${BATCH_SIZE} \
    --save_steps ${SAVE_STEPS} \
    --seed ${SEED} \
    --do_train \
    --do_eval \
    --do_predict \
    --overwrite_output_dir \
    |& tee -a "${SAVE_DIR}"/"${DATASET}"/"${NER_MODEL}"/stdout.txt
