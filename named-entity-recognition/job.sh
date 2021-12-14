#!/bin/bash
#PBS -N ZPJa_Biobert
#PBS -l select=1:ngpus=1:ncpus=2:mem=32gb:gpu_cap=cuda75:scratch_local=20gb
#PBS -q gpu
#PBS -l walltime=12:00:00
#PBS -m ae
# The 4 lines above are options for scheduling system: job will run 12 hours at maximum, 1 machine with 4 processors + 4gb RAM memory + 10gb scratch memory are requested, email notification will be sent when the job aborts (a) or ends (e)
# Díky gpu_cap můžou být imo jen následující clustery:
# adan (T4 16GB), zia (A100 40GB), gita (2080Ti 11GB)
# https://wiki.metacentrum.cz/wiki/GPU_stroje

# ASSUMED DIRECTORY TO RUN FROM: now

ln -s "$SCRATCHDIR" scratch

# define a CODE_DIR variable: directory where the input files are taken from and where output will be copied to
HOME_DIR=/storage/brno3-cerit/home/petrmiculek
CODE_DIR="${HOME_DIR}/biobert-pytorch"
DATETIME=$(date '+%m-%d_%H-%M-%S')
RUN_DIR="${HOME_DIR}/now/${DATETIME}"

# test if scratch directory is set
# if scratch directory is not set, issue error message and exit
test -n "$SCRATCHDIR" || { echo >&2 "Variable SCRATCHDIR is not set!"; exit 1; }

# append a line to a file "jobs_info.txt" containing the ID of the job, the hostname of node it is run on and the path to a scratch directory
# this information helps to find a scratch directory in case the job fails and you need to remove the scratch directory manually
echo "$PBS_JOBID is running on node `hostname -f`, with gpu: `nvidia-smi -L`, in a scratch directory $SCRATCHDIR" >> "${HOME_DIR}/jobs_info.txt"

#mkdir -p "${SCRATCHDIR}/datasets/NER/"
#cp -r "${CODE_DIR}/../datasets/NER/" "${SCRATCHDIR}/datasets/" || { echo >&2 "Error while copying input file(s)!"; exit 2; }

## OUT_FILES IN STORAGE:
mkdir -p "$RUN_DIR"
cd "$RUN_DIR" || { echo >&2 "could not cd to ${RUN_DIR} from `pwd`"; exit 2; }

cd "$SCRATCHDIR" || { echo >&2 "could not cd to ${SCRATCHDIR} from `pwd`"; exit 2; }
mkdir -p in
cd in || { echo >&2 "could not cd to 'in' from `pwd`)"; exit 2; }

export CODE_DIR
export SCRATCHDIR

# !!WARNING!! - running train.sh
singularity run --nv /cvmfs/singularity.metacentrum.cz/NGC/PyTorch\:21.11-py3.SIF "${CODE_DIR}/named-entity-recognition/eval_all.sh"

#rm -rf "${SCRATCHDIR}/datasets"
cp -r "$SCRATCHDIR" "$RUN_DIR"

# clean_scratch
