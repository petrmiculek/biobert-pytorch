#!/bin/bash

export SAVE_DIR=./output
export DATA_DIR=../datasets/NER

export MAX_LENGTH=192
export BATCH_SIZE=8
export NUM_EPOCHS=1
export SAVE_STEPS=1000
#export ENTITY=NCBI-disease  # passed from outside as a env variable
export SEED=1

# alternative models:
# dmis-lab/biobert-base-cased-v1.2
# dmis-lab/biobert-v1.1
# dmis-lab/bern2-ner

python run_ner.py \
    --data_dir ${DATA_DIR}/"${ENTITY}"/ \
    --labels ${DATA_DIR}/"${ENTITY}"/labels.txt \
    --model_name_or_path dmis-lab/biobert-base-cased-v1.1 \
    --output_dir ${SAVE_DIR}/"${ENTITY}" \
    --max_seq_length ${MAX_LENGTH} \
    --num_train_epochs ${NUM_EPOCHS} \
    --per_device_train_batch_size ${BATCH_SIZE} \
    --save_steps ${SAVE_STEPS} \
    --seed ${SEED} \
    --do_eval \
    --do_predict \
    --overwrite_output_dir
#    --do_train
