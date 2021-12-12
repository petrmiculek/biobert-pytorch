#!/bin/bash

export SAVE_DIR=./output
export DATA_DIR=../datasets/NER

export MAX_LENGTH=192
export BATCH_SIZE=8
export NUM_EPOCHS=1
export SAVE_STEPS=1000
#export ENTITY=NCBI-disease  # passed from outside as a env variable
export SEED=1

python run_ner.py \
    --data_dir ${DATA_DIR}/"${ENTITY}"/ \
    --labels ${DATA_DIR}/"${ENTITY}"/labels.txt \
    --model_name_or_path "${MODEL}" \
    --output_dir ${SAVE_DIR}/"${ENTITY}" \
    --max_seq_length ${MAX_LENGTH} \
    --num_train_epochs ${NUM_EPOCHS} \
    --per_device_train_batch_size ${BATCH_SIZE} \
    --save_steps ${SAVE_STEPS} \
    --seed ${SEED} \
    --do_train \
    --do_eval \
    --do_predict \
    --overwrite_output_dir
