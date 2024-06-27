#!/bin/bash

#SBATCH --mail-type=NONE
#SBATCH --output=/home/gianmauro.cuccuru/logs/%j_tdb_extraction.log
#SBATCH --partition=cpuq
#SBATCH --nodes=1 --ntasks-per-node=1 --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --job-name=tdb_extr
#SBATCH --time=0-24:00:00

PROJECT_DIR="/group/diangelantonio/users/gmauro/tiledb_extractions"

source ~/.bashrc
conda activate dask

date; echo "Starting to process"

time python "${PROJECT_DIR}/scripts/extract.py"

date; echo "finished"
