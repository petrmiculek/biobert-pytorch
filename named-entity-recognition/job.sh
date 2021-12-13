#!/bin/bash
#PBS -N ZPJa_Biobert
#PBS -l select=1:ngpus=1:ncpus=4:mem=32gb:scratch_local=10gb
#PBS -l walltime=12:00:00 
#PBS -m ae
# The 4 lines above are options for scheduling system: job will run 12 hours at maximum, 1 machine with 4 processors + 4gb RAM memory + 10gb scratch memory are requested, email notification will be sent when the job aborts (a) or ends (e)

# define a DATADIR variable: directory where the input files are taken from and where output will be copied to
DATADIR=/storage/brno3-cerit/home/petrmiculek/biobert-pytorch/named-entity-recognition

cd "$DATADIR"

SCRATCHDIR="$DATADIR"

# append a line to a file "jobs_info.txt" containing the ID of the job, the hostname of node it is run on and the path to a scratch directory
# this information helps to find a scratch directory in case the job fails and you need to remove the scratch directory manually 
echo "$PBS_JOBID is running on node `hostname -f` in a scratch directory $SCRATCHDIR" >> $DATADIR/jobs_info.txt

singularity shell --nv /cvmfs/singularity.metacentrum.cz/NGC/PyTorch\:21.11-py3.SIF

# test if scratch directory is set
# if scratch directory is not set, issue error message and exit
test -n "$SCRATCHDIR" || { echo >&2 "Variable SCRATCHDIR is not set!"; exit 1; }

# copy input file "h2o.com" to scratch directory
# if the copy operation fails, issue error message and exit
# cp $DATADIR/h2o.com  $SCRATCHDIR || { echo >&2 "Error while copying input file(s)!"; exit 2; }

# move into scratch directory
# cd $SCRATCHDIR 

# run Gaussian 03 with h2o.com as input and save the results into h2o.out file
# if the calculation ends with an error, issue error message an exit
# g03 <h2o.com >h2o.out || { echo >&2 "Calculation ended up erroneously (with a code $?) !!"; exit 3; }

# move the output to user's DATADIR or exit in case of failure
# cp h2o.out $DATADIR/ || { echo >&2 "Result file(s) copying failed (with a code $?) !!"; exit 4; }

bash -c eval_all.sh || { echo >&2 "Calculation ended up erroneously (with a code $?) !!"; exit 3; }

# cp -r logs $DATADIR || { echo >&2 "Result file(s) copying failed (with a code $?) !!"; exit 4; }
# clean the SCRATCH directory
#clean_scratch