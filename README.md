[![pipeline status](https://gitlab.ebi.ac.uk/ensreg/rdr/badges/main/pipeline.svg)](https://gitlab.ebi.ac.uk/ensreg/rdr/-/commits/main)

# Schema Documentation
- [Docs](docs/schemaspy/index.html)
- [Relationships](docs/schemaspy/relationships.html)


Generated with [SchemaSpy](https://schemaspy.org/).

# Regulation Data Registry

Ensembl Regulation Data Registry (RDR). The purpose of this database is to structure experiment metadata from external
public archives and provide a unified way to interact with it. The design considerations for the schema are:

- Support for multiple species.
- Support for multiple genome assemblies per species.
- Generic enough to support multiple experimental data sources.
- Extensible to other types of experiments, within reason.
- References to files. Focus on structuring metadata relevant to regulation analysis, and avoid including information
  available and easily accessible from files (e.g. BAM, BED, BigWig, etc...).
- Source of truth for experimental data the team is interested in processing
- Independent from the Ensembl release cycle. The DB should be able to evolve gradually. The data considered worth
  releasing, based on quality and priority planning, should point to specific DB versions, managed using git tags and
  archived as container images.

### Supported sources

- [ENCODE](https://www.encodeproject.org/)
- [FAANG Data Portal](https://data.faang.org/home)
- [ENA](https://www.ebi.ac.uk/ena/browser/home)
- [BioSamples](https://www.ebi.ac.uk/biosamples/)

### Supported experiments

- ATAC-seq
- DNase-seq
- ChIP-seq

## Data model (TODO)

## Using RDR Container Image

### Local development

#### Requirements

- [Podman](https://podman.io/docs/installation) 6+ and [podman-compose](https://github.com/containers/podman-compose) 1.6+
  (or Docker with Compose v2)
- Make and a POSIX shell (WSL on Windows)

On macOS, install the tools and start a Linux VM:

```bash
brew install podman podman-compose
podman machine init
podman machine start
```

On Linux, install Podman and podman-compose through your package manager;
no VM is needed. On Windows, use the commands from a WSL environment with Podman
installed and configured there.

Commands prefer Podman when installed and otherwise use Docker. Select explicitly
with `CONTAINER_ENGINE=podman make db-up` or `CONTAINER_ENGINE=docker make db-up`.
The selected engine must be running; commands never switch engines after a failure.
Podman always uses podman-compose, so Docker is not required. Images, volumes and
running databases are separate for each engine; use the same engine consistently.

#### DB up & running

Clone the repository, enter it, and start the checked-out snapshot:

```bash
git clone https://gitlab.ebi.ac.uk/ensreg/rdr
cd rdr
make db-up
```

`db-up` downloads the selected revision's DVC data, builds and starts PostgreSQL,
waits for initialization, and prints connection details. No `.env` is required.
It runs `db-data-pull`, `db-start`, `db-wait`, and `db-info` in order.
Defaults are PostgreSQL 14 at `127.0.0.1:2345`, database `rdr`, user `ensreg-usr`, password
`rdr-local-password`. Copy `.env.example` to `.env` to override local settings.

To use another snapshot, check out its Git tag or commit before running `make db-up`.
Save any local database changes before changing revisions or rebuilding the container.

#### Saving changes and shutting down

The database uses temporary storage, with no persistent data volume. Stopping or
removing its container discards database changes. Export anything worth keeping first:

```bash
make db-dump    # Export both schema and table data into db/
make db-down   # Remove the disposable database
```

Dumping does not commit or upload anything. Review the exports, then decide whether
to update DVC pointers, upload the data, and commit the changes.

### Managing data with DVC

DVC uses the selected container engine and Compose provider.
No local DVC installation or running database is needed. The image builds on first use.
Container configuration lives in `containers/`. Its shared `compose.dvc.yml`
uses `compose.dvc.podman.yml` or `compose.dvc.docker.yml` for engine-specific settings.

```bash
make db-data-pull          # Download the current dumps
./scripts/dvc.sh status    # Run any DVC command through the container
```

To push, add your bucket write credentials to Git-ignored `.dvc/config.local`:

```ini
['remote "ensreg-git-lfs"']
    access_key_id = <your-access-key>
    secret_access_key = <your-secret-key>
```

```bash
chmod 600 .dvc/config.local
```

After regenerating the dumps, update their pointers and upload the data:

```bash
./scripts/dvc.sh add db/*_public_*.sql
make db-data-push
```

Commit the schema, `.dvc` pointers and `db/.gitignore` together. Remove obsolete
pointers and dumps if tables are removed or renumbered.

Pulls use the public HTTP remote; pushes use `ensreg-git-lfs` on
`https://livingobjects.ebi.ac.uk`. For authenticated pulls, use
`./scripts/dvc.sh pull -r ensreg-git-lfs`.

Run `make dvc-build` to rebuild with base-image security updates. DVC dependencies
are managed in `containers/dvc/pyproject.toml` and `containers/dvc/uv.lock`.

### Pre-built container image

#### Requirements

The configuration in this repository ensures that we have container images associated with data included in each Ensembl
release cycle. These container images are built and published in the Regulation's Gitlab Container
Registry [RDR container registry](https://gitlab.ebi.ac.uk/ensreg/rdr/container_registry).

The jobs responsible for building and publishing the container images in the CI pipeline are only triggered by commits
in the `main` branch and via Git tags. Image tags correspond to git tags in this repository.

We typically use git tags that follow [semantic versioning (SemVer)](https://semver.org/) to track changes to the DB
schema and as we register primary or our own results data. Additionally, we use git tags that don't follow SemVer to
label database
versions when handing over results to be published as part of an Ensembl release (e.g., 'r111'). Other tags can be used
for proof of concepts or analyses that are outside the scope of the release cycle but worth tracking and sharing.

For pulling a specific pre-built image, use the following command:

```
./scripts/container.sh pull dockerhub.ebi.ac.uk/ensreg/rdr/rdr:<image-tag>
```

To spin up a local database instance pointiong to a specific commit, check
the [Local development section](#local-development) for instructions.

### Production (TODO)

## License

This project is licensed under the Apache License 2.0 – see the [LICENSE](./LICENSE) file for details.
