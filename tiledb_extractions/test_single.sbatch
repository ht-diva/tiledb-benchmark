#!/bin/bash

#SBATCH --mail-type=NONE
#SBATCH --output=/home/gianmauro.cuccuru/logs/%j_tiledb_extraction.log
#SBATCH --partition=cpuq
#SBATCH --nodes=1 --ntasks-per-node=1 --cpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --job-name=tdb_extr
#SBATCH --time=0-00:60:00

source /project/snip/.singularity_functions

time tiledbvcf export \
  --uri $TILEDB_DIR/pqtls \
  --output-format t \
  --output-path /group/diangelantonio/users/gmauro/tiledb_extractions/datainfo_single.tsv \
  --sample-names pqtls_1 \
  --mem-budget-mb 20480 \
  --tsv-fields SAMPLE,QUAL,FILTER,CHR,POS,ID,REF,ALT,I:AF,F:ES,F:SE,F:LP,F:SS,F:EZ,F:SI,F:NC,F:ID \
  --regions-file /group/diangelantonio/users/gmauro/tiledb_extractions/bed_ensembl_SomaScan_V4.1_7K_Annotated_Content_20210616_bed_for_extraction.bed

