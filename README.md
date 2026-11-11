# Regulation Data Registry

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

## Schema overview

Epigenomes group experiments by biological context. Assay-specific tables connect
experiments to sets of replicates; each replicate links sequencing reads to a
set of biological samples. Analysis files associate an experiment with a genome
assembly and a registered file.

```mermaid
---
config:
  theme: base
  themeCSS: |
    .edgeLabel rect { opacity: 1; }
    .labelBkg { background-color: #f8fafc; }
  themeVariables:
    primaryTextColor: '#0f172a'
    secondaryTextColor: '#0f172a'
    tertiaryTextColor: '#0f172a'
    textColor: '#0f172a'
    lineColor: '#64748b'
    edgeLabelBackground: '#f8fafc'
    clusterBkg: '#f8fafc'
    clusterBorder: '#64748b'
    titleColor: '#0f172a'
  flowchart:
    htmlLabels: false
---
flowchart LR
    subgraph core["Experiments and sequencing"]
        direction LR
        epigenome -->|"1 : N"| experiment
        experiment -.->|"M : N via assay tables"| replicate_set
        replicate_set -->|"1 : N"| replicate
        replicate -->|"N : 1"| read_file_set
        read_file_set -->|"0..1 : N"| run
        run -->|"0..1 : N"| read_file
    end

    subgraph biology["Biological context and samples"]
        direction LR
        species
        epigenome_group
        biosource -->|"1 : N"| biosample
        biosample -->|"1 : N"| biosample_set_biosample
        biosample_set -->|"1 : N"| biosample_set_biosample
    end

    subgraph resources["References and registered files"]
        direction LR
        assembly -->|"1 : N"| analysis_file
        file -->|"1 : N"| analysis_file
    end

    epigenome -->|"1 : N"| track
    species -->|"1 : N"| epigenome
    epigenome_group -->|"1 : N"| epigenome
    biosample_set -->|"0..1 : N"| replicate
    species -->|"1 : N"| assembly
    experiment -->|"1 : N"| analysis_file
    file -->|"1 : N"| read_file
    read_file_set -->|"0..1 : N"| read_file

    classDef context fill:#dbeafe,stroke:#1d4ed8,color:#172554
    classDef assays fill:#ede9fe,stroke:#6d28d9,color:#2e1065
    classDef samples fill:#dcfce7,stroke:#15803d,color:#14532d
    classDef sequencing fill:#cffafe,stroke:#0e7490,color:#164e63
    classDef resources fill:#fef3c7,stroke:#b45309,color:#451a03
    class species,epigenome_group,epigenome,track context
    class experiment,replicate_set,replicate assays
    class biosource,biosample,biosample_set,biosample_set_biosample samples
    class read_file_set,run,read_file sequencing
    class assembly,analysis_file,file resources
```

Follow the main chain from left to right: biological context → experiment →
replicates → read-file set → sequencing run → read file. Blue marks biological
context, purple experiments and replicates, green samples, cyan sequencing, and
amber references and files.

Each label gives the cardinality at the source and destination: `1 : N` means
one-to-many, `N : 1` means many-to-one, and `M : N` means many-to-many. Here,
`N` and `M` allow zero or more rows; `0..1` marks an optional parent. For example,
each replicate references exactly one read-file set, but a read file can have no
run assigned. The sample-set membership table implements the many-to-many
relationship between `biosample_set` and `biosample`.

The overview above shows the main path through the schema. Together with the
four expandable sections below, it covers all 41 tables. Select a section title
to see its detailed diagram. Repeated boxes refer to the same table.

Solid arrows show foreign-key relationships, oriented for reading rather than
foreign-key direction. The dotted arrow in the overview summarizes the link
through the assay tables; it is not a direct foreign key. Cardinalities follow
each arrow from tail to head, including arrows pointing left. Columns and views
are omitted.

<details>
<summary><strong>Assay types and replicate sets</strong></summary>

Each assay has its own row, with `experiment` on the left and replicate sets
and targets on the right. Repeated boxes refer to the same tables, drawn
separately to avoid crossing arrows. Labels use
the same cardinality notation as the other diagrams; signal/control and ATAC/RNA
distinguish the roles of replicate sets. Cardinalities follow the arrow from
tail to head, including arrows pointing left.

```mermaid
---
config:
  theme: base
  themeCSS: |
    .edgeLabel rect { opacity: 1; }
    .labelBkg { background-color: #f8fafc; }
  themeVariables:
    primaryTextColor: '#0f172a'
    secondaryTextColor: '#0f172a'
    tertiaryTextColor: '#0f172a'
    textColor: '#0f172a'
    lineColor: '#64748b'
    edgeLabelBackground: '#f8fafc'
    clusterBkg: '#f8fafc'
    clusterBorder: '#64748b'
    titleColor: '#0f172a'
  flowchart:
    htmlLabels: false
---
flowchart TB
    subgraph atac_panel["ATAC-seq"]
        direction LR
        atac_experiment["experiment"] -->|"1 : 0..1"| atac_seq
        atac_seq <-->|"1 : 0..1"| atac_replicates["replicate_set"]
    end

    subgraph dnase_panel["DNase-seq"]
        direction LR
        dnase_experiment["experiment"] -->|"1 : 0..1"| dnase_seq
        dnase_seq <-->|"1 : 0..1"| dnase_replicates["replicate_set"]
    end

    subgraph rna_panel["RNA-seq"]
        direction LR
        rna_experiment["experiment"] -->|"1 : 0..1"| rna_seq
        rna_seq <-->|"1 : 0..1"| rna_replicates["replicate_set"]
    end

    subgraph chip_panel["ChIP-seq"]
        direction LR
        chip_experiment["experiment"] -->|"1 : 0..1"| chip_seq
        chip_seq <-->|"1 : 0..1 signal"| chip_signal["replicate_set"]
        chip_seq <-->|"0..1 : N control"| chip_control["replicate_set"]
        chip_seq <-->|"0..1 : N"| chip_histone["histone_target"]
        chip_seq <-->|"0..1 : N"| chip_tf["tf_target"]
    end

    subgraph multiome_panel["Multiome"]
        direction LR
        multiome_experiment["experiment"] -->|"1 : 0..1"| multiome
        multiome <-->|"1 : 0..1 ATAC"| multiome_atac["replicate_set"]
        multiome <-->|"0..1 : 0..1 RNA"| multiome_rna["replicate_set"]
    end

    %% Keep right-hand nodes on the right, with arrowheads only at the assay.
    linkStyle 1,3,5,7,8,9,10,12,13 marker-end:none

    %% Invisible links keep the independent assay rows stacked vertically.
    atac_panel ~~~ dnase_panel ~~~ rna_panel ~~~ chip_panel ~~~ multiome_panel

    classDef assays fill:#ede9fe,stroke:#6d28d9,color:#2e1065
    class atac_experiment,atac_replicates,atac_seq,dnase_experiment,dnase_replicates,dnase_seq,rna_experiment,rna_replicates,rna_seq,chip_experiment,chip_signal,chip_control,chip_histone,chip_tf,chip_seq,multiome_experiment,multiome_atac,multiome_rna,multiome assays
```

</details>

<details>
<summary><strong>Samples and biological annotations</strong></summary>

The membership table connects sample sets to samples. Life-stage and ontology
links add biological annotations; the optional sample-set link ties samples
to replicates.

```mermaid
---
config:
  theme: base
  themeCSS: |
    .edgeLabel rect { opacity: 1; }
    .labelBkg { background-color: #f8fafc; }
  themeVariables:
    primaryTextColor: '#0f172a'
    secondaryTextColor: '#0f172a'
    tertiaryTextColor: '#0f172a'
    textColor: '#0f172a'
    lineColor: '#64748b'
    edgeLabelBackground: '#f8fafc'
    clusterBkg: '#f8fafc'
    clusterBorder: '#64748b'
    titleColor: '#0f172a'
  flowchart:
    htmlLabels: false
---
flowchart LR
    biosource -->|"1 : N"| biosample
    life_stage -->|"0..1 : N"| biosample
    ontology -->|"0..1 : N"| biosample
    biosample -->|"1 : N"| biosample_set_biosample
    biosample_set -->|"1 : N"| biosample_set_biosample
    life_stage -->|"0..1 : N"| biosource
    ontology -->|"1 : N"| life_stage
    biosample_set -->|"0..1 : N"| replicate

    classDef assays fill:#ede9fe,stroke:#6d28d9,color:#2e1065
    class replicate assays
    classDef samples fill:#dcfce7,stroke:#15803d,color:#14532d
    class biosample,biosample_set,biosample_set_biosample,biosource,life_stage,ontology samples
```

</details>

<details>
<summary><strong>Files, locations, and processing</strong></summary>

File-role tables share the generic `file` registry. Locations are recorded
separately. The `run_alignment_task` membership table connects runs and alignment
tasks; an alignment file can optionally identify its task. Shared tables are
repeated across rows to keep the relationships separate.

```mermaid
---
config:
  theme: base
  themeCSS: |
    .edgeLabel rect { opacity: 1; }
    .labelBkg { background-color: #f8fafc; }
  themeVariables:
    primaryTextColor: '#0f172a'
    secondaryTextColor: '#0f172a'
    tertiaryTextColor: '#0f172a'
    textColor: '#0f172a'
    lineColor: '#64748b'
    edgeLabelBackground: '#f8fafc'
    clusterBkg: '#f8fafc'
    clusterBorder: '#64748b'
    titleColor: '#0f172a'
  flowchart:
    htmlLabels: false
---
flowchart TB
    subgraph reference["Reference assemblies"]
        direction LR
        reference_assembly["assembly"]
        reference_left_0["species"]
        reference_right_0["file"]
        reference_left_0 -->|"1 : N"| reference_assembly
        reference_assembly <-->|"1 : N"| reference_right_0
    end

    subgraph aligned["Alignment files"]
        direction LR
        aligned_alignment_file["alignment_file"]
        aligned_left_0["read_file_set"]
        aligned_left_1["assembly"]
        aligned_left_2["alignment_task"]
        aligned_right_0["file"]
        aligned_left_0 -->|"1 : N"| aligned_alignment_file
        aligned_left_1 -->|"1 : N"| aligned_alignment_file
        aligned_left_2 -->|"0..1 : N"| aligned_alignment_file
        aligned_alignment_file <-->|"1 : N"| aligned_right_0
    end

    subgraph analysis["Analysis files"]
        direction LR
        analysis_analysis_file["analysis_file"]
        analysis_left_0["experiment"]
        analysis_left_1["assembly"]
        analysis_right_0["file"]
        analysis_left_0 -->|"1 : N"| analysis_analysis_file
        analysis_left_1 -->|"1 : N"| analysis_analysis_file
        analysis_analysis_file <-->|"1 : N"| analysis_right_0
    end

    subgraph masks["Mask files"]
        direction LR
        masks_mask_file["mask_file"]
        masks_left_0["assembly"]
        masks_right_0["file"]
        masks_left_0 -->|"1 : N"| masks_mask_file
        masks_mask_file <-->|"1 : N"| masks_right_0
    end

    subgraph barcodes["Barcode files"]
        direction LR
        barcodes_barcode_file["barcode_file"]
        barcodes_left_0["run"]
        barcodes_right_0["file"]
        barcodes_left_0 -->|"1 : N"| barcodes_barcode_file
        barcodes_barcode_file <-->|"1 : N"| barcodes_right_0
    end

    subgraph storage["File locations and inclusion lists"]
        direction LR
        storage_file["file"]
        storage_s3["s3_object"]
        storage_bucket["bucket"]
        storage_posix["posix_file"]
        storage_url["public_url"]
        storage_inclusion["inclusion_list"]
        storage_file -->|"1 : N"| storage_s3
        storage_s3 <-->|"1 : N"| storage_bucket
        storage_file -->|"1 : N"| storage_posix
        storage_file -->|"1 : N"| storage_url
        storage_file -->|"1 : N"| storage_inclusion
    end

    subgraph tasks["Run and alignment-task membership"]
        direction LR
        tasks_run_alignment_task["run_alignment_task"]
        tasks_left_0["run"]
        tasks_right_0["alignment_task"]
        tasks_left_0 -->|"1 : N"| tasks_run_alignment_task
        tasks_run_alignment_task <-->|"1 : N"| tasks_right_0
    end

    %% Right-hand parents point back into the central table.
    linkStyle 1,5,8,10,12,14,19 marker-end:none

    %% Layout-only links stack the groups vertically.
    reference ~~~ aligned ~~~ analysis ~~~ masks ~~~ barcodes ~~~ storage ~~~ tasks

    classDef context fill:#dbeafe,stroke:#1d4ed8,color:#172554
    class reference_left_0 context
    classDef assays fill:#ede9fe,stroke:#6d28d9,color:#2e1065
    class analysis_left_0 assays
    classDef sequencing fill:#cffafe,stroke:#0e7490,color:#164e63
    class aligned_left_0,aligned_left_2,barcodes_left_0,tasks_run_alignment_task,tasks_left_0,tasks_right_0 sequencing
    classDef resources fill:#fef3c7,stroke:#b45309,color:#451a03
    class reference_assembly,reference_right_0,aligned_alignment_file,aligned_left_1,aligned_right_0,analysis_analysis_file,analysis_left_1,analysis_right_0,masks_mask_file,masks_left_0,masks_right_0,barcodes_barcode_file,barcodes_right_0,storage_file,storage_s3,storage_bucket,storage_posix,storage_url,storage_inclusion resources
```

</details>

<details>
<summary><strong>Provenance, curation, and schema version</strong></summary>

Archive accessions are recorded in `data_source` and referenced by the tables
shown below. Pink marks provenance. The gray tables have no foreign keys:
`metadata_override` and `quality_annotation` identify records by accession,
while `alembic_version` stores the schema migration version.

```mermaid
---
config:
  theme: base
  themeCSS: |
    .edgeLabel rect { opacity: 1; }
    .labelBkg { background-color: #f8fafc; }
  themeVariables:
    primaryTextColor: '#0f172a'
    secondaryTextColor: '#0f172a'
    tertiaryTextColor: '#0f172a'
    textColor: '#0f172a'
    lineColor: '#64748b'
    edgeLabelBackground: '#f8fafc'
    clusterBkg: '#f8fafc'
    clusterBorder: '#64748b'
    titleColor: '#0f172a'
  flowchart:
    htmlLabels: false
---
flowchart TB
    subgraph archives["Archive accessions"]
        direction LR
        prov_archive["archive"]
        prov_source["data_source"]
        prov_archive -->|"1 : N"| prov_source
    end

    subgraph sample_sources["Biological samples"]
        direction LR
        sample_source["data_source"]
        sample_biosource["biosource"]
        sample_biosample["biosample"]
        sample_set["biosample_set"]
        sample_alternative["data_source"]
        sample_source -->|"0..1 : N"| sample_biosource
        sample_source -->|"1 : N"| sample_biosample
        sample_source -->|"0..1 : N"| sample_set
        sample_biosource <-->|"0..1 : N alternative"| sample_alternative
        sample_biosample <-->|"0..1 : N alternative"| sample_alternative
    end

    subgraph experiment_sources["Epigenomes and experiments"]
        direction LR
        exp_source["data_source"]
        exp_epigenome["epigenome"]
        exp_group["epigenome_group"]
        exp_experiment["experiment"]
        exp_alternative["data_source"]
        exp_source -->|"0..1 : N"| exp_epigenome
        exp_source -->|"0..1 : N"| exp_group
        exp_source -->|"0..1 : N"| exp_experiment
        exp_epigenome <-->|"0..1 : N alternative"| exp_alternative
    end

    subgraph sequence_sources["Replicates, sequencing, and files"]
        direction LR
        seq_source["data_source"]
        seq_replicate["replicate"]
        seq_replicate_set["replicate_set"]
        seq_read_set["read_file_set"]
        seq_run["run"]
        seq_read["read_file"]
        seq_barcode["barcode_file"]
        seq_file["file"]
        seq_replicate <-->|"0..1 : N"| seq_source
        seq_replicate_set <-->|"0..1 : N"| seq_source
        seq_read_set <-->|"0..1 : N"| seq_source
        seq_source -->|"0..1 : N"| seq_run
        seq_source -->|"0..1 : N"| seq_read
        seq_source -->|"0..1 : N"| seq_barcode
        seq_source -->|"0..1 : N"| seq_file
    end

    subgraph curation["Curation and schema version - no foreign keys"]
        direction LR
        curation_metadata["metadata_override"]
        curation_quality["quality_annotation"]
        curation_version["alembic_version"]
        curation_metadata ~~~ curation_quality
        curation_quality ~~~ curation_version
    end

    %% Right-hand parents point back into the central table.
    linkStyle 4,5,9,10,11,12 marker-end:none

    %% Layout-only links stack the groups vertically.
    archives ~~~ sample_sources ~~~ experiment_sources ~~~ sequence_sources ~~~ curation

    classDef context fill:#dbeafe,stroke:#1d4ed8,color:#172554
    class exp_epigenome,exp_group context
    classDef assays fill:#ede9fe,stroke:#6d28d9,color:#2e1065
    class exp_experiment,seq_replicate,seq_replicate_set assays
    classDef samples fill:#dcfce7,stroke:#15803d,color:#14532d
    class sample_biosource,sample_biosample,sample_set samples
    classDef sequencing fill:#cffafe,stroke:#0e7490,color:#164e63
    class seq_read_set,seq_run,seq_read sequencing
    classDef resources fill:#fef3c7,stroke:#b45309,color:#451a03
    class seq_barcode,seq_file resources
    classDef provenance fill:#ffe4e6,stroke:#be123c,color:#4c0519
    class prov_archive,prov_source,sample_source,sample_alternative,exp_source,exp_alternative,seq_source provenance
    classDef curation fill:#f1f5f9,stroke:#475569,color:#0f172a
    class curation_metadata,curation_quality,curation_version curation
```

</details>

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

`db/schema.sql` contains the schema and is tracked in Git. `db/data.sql` contains
only table data and sequence values and is tracked by DVC. The export creates one
temporary archive and extracts both SQL files from the same database snapshot.
Initialization loads the schema first, followed by the data in PostgreSQL's
dependency-safe dump order. Use the matching PostgreSQL 14 client and server
images supplied by the container setup.

Export does not run a second database. Before publishing, validate the SQL files:

```bash
make db-validate
```

Validation restores the SQL files into a disposable database without publishing a
port. After reviewing the schema and validation result, update the single pointer:

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

Commit `db/schema.sql` and `db/data.sql.dvc` together. Exporting, validating,
and uploading data do not create Git commits. Exports are staged before replacing
the previous files. An export may produce a new dump hash even when rows have
not changed: PostgreSQL includes random restriction keys and version comments,
and row order can change. Restriction protection is retained; byte-for-byte
reproducibility is not promised.

Use `make db-dump` to keep the schema and data together.
Apply changes to the local database and export them. The next fresh instance
loads the Git-versioned schema and DVC-versioned data.

Upload new data objects before sharing Git commits that reference them. This
format starts a fresh DVC baseline: obsolete snapshot objects have been purged.
Earlier Git revisions retain their pointers, but their snapshots can no longer
be pulled from the remote.

### Update schema documentation

With the local database running, regenerate the HTML and relationship diagrams:

```bash
make db-up           # If the database is not already running
make schemaspy-docs
```

This uses the pinned SchemaSpy 7.0.2 container with its bundled PostgreSQL driver
and Graphviz; no local Java installation is needed. It reads the `public` schema
from the current local database, including any schema changes you have applied.
It uses the same engine, `DB_PROJECT`, and `.env` connection settings as the
database commands. It waits for PostgreSQL without restarting the database.

Generation replaces `docs/schemaspy/` only after succeeding, removing obsolete
pages for dropped tables. Failed generation preserves the existing docs. Row
counts are omitted so the documentation focuses on the schema. The container
runs with your user ID so generated files remain editable.

Preview locally:

```bash
python3 -m http.server 8000 --bind 127.0.0.1 --directory docs
```

Open <http://localhost:8000/schemaspy/>. Review and commit `docs/schemaspy/`
alongside the corresponding `db/schema.sql` changes after `make db-dump`.

### Tooling

Container configuration and the locked DVC environment live in `containers/`.
Use `make dvc-build` to rebuild with base-image updates, and `./scripts/dvc.sh -h`
for DVC wrapper usage. Run workflow tests with `python3 -m unittest discover -s tests`.

## License

[Apache License 2.0](LICENSE).
