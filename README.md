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

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### DB up & running

Clone this repository and run the following command to spin up a local database instance:

```bash
git clone https://gitlab.ebi.ac.uk/ensreg/rdr
```

```bash
make test-db-up
```

The database will be available at `localhost:2345` with the following credentials:

```
Database: `rdr`
User: `regulation_usr`
Password: `docker`
```

If you want to spin up the DB version corresponding to a specific commit, tag, or branch, `git checkout` to the desired
reference and then run `make test-db-up`.

#### DB down

To stop the database instance, run the following command:

```bash
make test-db-down
```

### Managing data with DVC

DVC runs in a container using Docker Compose v2 and a POSIX shell (WSL on Windows).
No local DVC installation or running database is needed. The image builds on first use.

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
docker pull dockerhub.ebi.ac.uk/ensreg/rdr/rdr:<image-tag>
```

To spin up a local database instance pointiong to a specific commit, check
the [Local development section](#local-development) for instructions.

### Production (TODO)

## License

This project is licensed under the Apache License 2.0 – see the [LICENSE](./LICENSE) file for details.
