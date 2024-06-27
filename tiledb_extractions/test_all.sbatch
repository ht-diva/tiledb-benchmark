#!/bin/bash

#SBATCH --mail-type=NONE
#SBATCH --output=/home/gianmauro.cuccuru/logs/%j_tiledb_extraction.log
#SBATCH --partition=cpuq
#SBATCH --nodes=1 --ntasks-per-node=1 --cpus-per-task=1
#SBATCH --mem=50GB
#SBATCH --job-name=tdb_extr
#SBATCH --time=0-24:00:00

source /project/snip/.singularity_functions

time tiledbvcf export \
  --uri $TILEDB_DIR/pqtls \
  --output-format t \
  --output-path /group/diangelantonio/users/gmauro/tiledb_extractions/datainfo_all_one_region.tsv \
  --samples-file /group/diangelantonio/users/gmauro/tiledb_extractions/ids_list.txt \
  --mem-budget-mb 20480 \
  --tsv-fields SAMPLE,QUAL,FILTER,CHR,POS,ID,REF,ALT,I:AF,F:ES,F:SE,F:LP,F:SS,F:EZ,F:SI,F:NC,F:ID \
  --regions  chr1:43337848-43352772,chrX:140111605-142111605
#  --regions-file /group/diangelantonio/users/gmauro/tiledb_extractions/bed_ensembl_SomaScan_V4.1_7K_Annotated_Content_20210616_bed_for_extraction.bed

