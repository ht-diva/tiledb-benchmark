from dask_jobqueue import SLURMCluster as Cluster

# config in $HOME /.config/dask/jobqueue.yaml
cluster = Cluster()

cluster.adapt(minimum=10, maximum=100)
# cluster.scale(100)  # Start 100 workers in 100 jobs that match the description above

from dask.distributed import Client
client = Client(cluster)    # Connect to that cluster

import tiledbvcf
import dask

dask.config.set({"dataframe.convert-string": True})

print(dask.config.config)

cfg = tiledbvcf.ReadConfig(memory_budget_mb=20480)
ds = tiledbvcf.Dataset('/scratch/gianmauro.cuccuru/tiledb/datasets/pqtls', mode='r', cfg=cfg)
dask_df = ds.read_dask(attrs=['sample_name', 'contig', 'pos_start', 'pos_end', 'alleles', 'fmt_SE'],
                       bed_file='/group/diangelantonio/users/gmauro/tiledb_extractions/bed_ensembl_SomaScan_V4.1_7K_Annotated_Content_20210616_bed_for_extraction.bed',
                       samples_file='/group/diangelantonio/users/gmauro/tiledb_extractions/ids_list_all.txt',
                       region_partitions=10,
                       sample_partitions=500)

print(dask_df.head)
print(dask_df.dtypes)
dask_df.to_csv('/scratch/gianmauro.cuccuru/datainfo_all.tsv', sep="\t")
