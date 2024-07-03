import pathlib
import tiledb
import tiledbvcf

cfg = tiledb.Config()
cfg["vfs.s3.aws_access_key_id"] = ""
cfg["vfs.s3.aws_secret_access_key"] = ""
cfg["vfs.s3.endpoint_override"] = "storage.fht.org:9021"
cfg["vfs.s3.use_virtual_addressing"] = "false"
cfg["vfs.s3.scheme"] = "https"
cfg["vfs.s3.region"] = ""
cfg["vfs.s3.verify_ssl"] = "false"
read_cfg = tiledbvcf.ReadConfig(tiledb_config=cfg)

uri="s3://s3-tiledb-test/pqtls-trial-slim"
ds = tiledbvcf.Dataset(uri, mode = "w", cfg = read_cfg)
ds.create_dataset(extra_attrs=[ "fmt_ES", "fmt_SE"])

p =pathlib.Path("/project/snip/gvs2tiledb/believe/vcf")

ds.ingest_samples(threads=8, sample_uris = [ str(l) for l in list(p.glob("*.gz"))])

                  


