# Regulation Data Registry

[![pipeline status](https://gitlab.ebi.ac.uk/ensreg/rdr/badges/main/pipeline.svg)](https://gitlab.ebi.ac.uk/ensreg/rdr/-/commits/main)

The Ensembl Regulation Data Registry (RDR) structures experiment metadata from
public archives, including ENCODE, FAANG, ENA and BioSamples, and provides a
unified way to work with it. It records experiments relevant to Ensembl Regulation
and references their data files rather than duplicating information available
in those files.

The schema supports multiple species and genome assemblies and can accommodate
additional data sources and experiment types. The database is versioned
independently of Ensembl releases so that its schema and contents can evolve
as new data is registered. This repository distributes snapshots that users can
run and query locally, with Git tags identifying specific versions.

The schema documentation describes the [tables](docs/schemaspy/index.html) and
their [relationships](docs/schemaspy/relationships.html).

### Supported data sources

- [ENCODE](https://www.encodeproject.org/)
- [FAANG Data Portal](https://data.faang.org/home)
- [ENA](https://www.ebi.ac.uk/ena/browser/home)
- [BioSamples](https://www.ebi.ac.uk/biosamples/)

### Supported experiments

The current snapshot contains the following experiment types:

- ATAC-seq
- DNase-seq
- ChIP-seq

## Run a local database

You need Git, Make, a POSIX shell, and either:

- [Podman](https://podman.io/docs/installation) 6+ with [podman-compose](https://github.com/containers/podman-compose) 1.6+; or
- Docker with Compose v2.

Start your container engine first. On macOS, Podman needs a VM:

```bash
podman machine init     # Once, after installing Podman
podman machine start
```

Then clone and start RDR:

```bash
git clone https://gitlab.ebi.ac.uk/ensreg/rdr
cd rdr
make db-up
```

This downloads the snapshot, builds PostgreSQL, waits for initialization, and
prints connection details. No bucket credentials, local DVC installation, or
`.env` file are needed.

Connect with your preferred PostgreSQL client:

| Setting | Default |
| --- | --- |
| Host | `127.0.0.1` |
| Port | `2345` |
| Database | `rdr` |
| User | `ensreg-usr` |
| Password | `rdr-local-password` |

Or open `psql` using the container, with the default credentials:

```bash
./scripts/container.sh compose -p rdr exec db psql -U ensreg-usr -d rdr
```

Copy `.env.example` to `.env` to override settings. Commands prefer Podman when
installed; use `CONTAINER_ENGINE=docker make db-up` to select Docker explicitly.
Use the same engine for subsequent commands.

When finished:

```bash
make db-down
```

The database is disposable: stopping or removing the container discards local
changes. See [Development](#development) to export changes before stopping.

### Choose a snapshot

Check out the desired Git tag or commit before running `make db-up`.
When switching an existing instance, run `make db-down` before changing revisions.

## Development

### Export and publish changes

After editing the local database, export both schema and data:

```bash
make db-dump
```

The snapshot is stored as one compressed PostgreSQL archive, `db/data.dump`,
tracked by DVC. It contains the complete schema and data. `db/schema.sql` is
extracted from that same archive and tracked in Git so schema changes can be
reviewed as SQL. Startup restores the archive directly with `pg_restore`.

Export checks that the archive's table of contents is readable. After reviewing
the schema, update the single pointer:

```bash
make db-data-track
./scripts/dvc.sh status
```

To upload data, configure your bucket write credentials in Git-ignored
`.dvc/config.local`:

```ini
['remote "ensreg-git-lfs"']
    access_key_id = <your-access-key>
    secret_access_key = <your-secret-key>
```

```bash
chmod 600 .dvc/config.local
make db-data-push
```

Commit `db/schema.sql` and `db/data.dump.dvc` together. Exporting and uploading data do not create Git commits. Exports are staged before replacing
the previous files. An export may produce a new archive hash even when rows have
not changed; byte-for-byte reproducibility and per-table uploads are not promised.

Normally use `make db-dump` to keep the archive and reviewed schema together.
`make db-schema-dump` and `make db-data-dump` are aliases for the same full export. Editing the review
SQL alone does not change the database: apply schema changes to the local database
and export them.

The numbered per-table dumps and their pointers have been replaced by the archive.
The original snapshot and pointers are backed up under
`.dvc/tmp/single-archive-migration-*/db/`. Existing cached objects are retained;
new archive objects must be uploaded explicitly before sharing their Git pointers.

### Tooling

Container configuration and the locked DVC environment live in `containers/`.
Use `make dvc-build` to rebuild with base-image updates, and `./scripts/dvc.sh -h`
for DVC wrapper usage. Run workflow tests with `python3 -m unittest discover -s tests`.

## License

[Apache License 2.0](LICENSE).
