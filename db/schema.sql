--
-- PostgreSQL database dump
--

\restrict 2ALktoMjlcQC9npvHKuhbuJoLT9RR2e9SgJdAgOo26ErKorhweOQcCmw4bSiexV

-- Dumped from database version 14.24 (Debian 14.24-1.pgdg13+2)
-- Dumped by pg_dump version 14.24 (Debian 14.24-1.pgdg13+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: age_unit_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.age_unit_type AS ENUM (
    'day',
    'hour',
    'month',
    'thermal_time',
    'week',
    'year'
);


ALTER TYPE public.age_unit_type OWNER TO "ensreg-usr";

--
-- Name: analysis_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.analysis_type AS ENUM (
    'atac_seq_peaks',
    'broad_peaks',
    'chip_seq_broad_peaks',
    'chip_seq_gapped_peaks',
    'chip_seq_narrow_peaks',
    'control_peaks',
    'coverage',
    'dnase_seq_peaks',
    'gapped_peaks',
    'genrich_pileups',
    'genrich_pq_values',
    'genrich_values',
    'narrow_peaks',
    'peaks',
    'signal'
);


ALTER TYPE public.analysis_type OWNER TO "ensreg-usr";

--
-- Name: biomaterial_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.biomaterial_type AS ENUM (
    'cell_line',
    'primary_cell',
    'primary_cell_culture',
    'primary_tissue'
);


ALTER TYPE public.biomaterial_type OWNER TO "ensreg-usr";

--
-- Name: biosample_set_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.biosample_set_type AS ENUM (
    'individual',
    'pool_of_specimens'
);


ALTER TYPE public.biosample_set_type OWNER TO "ensreg-usr";

--
-- Name: data_source_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.data_source_type AS ENUM (
    'entrypoint',
    'embedded'
);


ALTER TYPE public.data_source_type OWNER TO "ensreg-usr";

--
-- Name: experiment_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.experiment_type AS ENUM (
    'chip_seq',
    'atac_seq',
    'dnase_seq'
);


ALTER TYPE public.experiment_type OWNER TO "ensreg-usr";

--
-- Name: file_system_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.file_system_type AS ENUM (
    's3_object',
    'posix_file',
    'public_url'
);


ALTER TYPE public.file_system_type OWNER TO "ensreg-usr";

--
-- Name: file_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.file_type AS ENUM (
    'bam',
    'bed',
    'bigwig',
    'fasta',
    'fastq',
    'txt'
);


ALTER TYPE public.file_type OWNER TO "ensreg-usr";

--
-- Name: histone_target_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.histone_target_type AS ENUM (
    'H3K4me3',
    'H3K27ac',
    'H3K27me3',
    'H3K4me1'
);


ALTER TYPE public.histone_target_type OWNER TO "ensreg-usr";

--
-- Name: mark_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.mark_type AS ENUM (
    'broad',
    'narrow'
);


ALTER TYPE public.mark_type OWNER TO "ensreg-usr";

--
-- Name: ontology_relation_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.ontology_relation_type AS ENUM (
    'child_of',
    'direct'
);


ALTER TYPE public.ontology_relation_type OWNER TO "ensreg-usr";

--
-- Name: ontology_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.ontology_type AS ENUM (
    'CL',
    'CLO',
    'EFO',
    'NTR',
    'UBERON'
);


ALTER TYPE public.ontology_type OWNER TO "ensreg-usr";

--
-- Name: quality_annotation_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.quality_annotation_type AS ENUM (
    'exclude',
    'warn',
    'pass'
);


ALTER TYPE public.quality_annotation_type OWNER TO "ensreg-usr";

--
-- Name: run_grouping_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.run_grouping_type AS ENUM (
    'run_type_read_length'
);


ALTER TYPE public.run_grouping_type OWNER TO "ensreg-usr";

--
-- Name: run_order_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.run_order_type AS ENUM (
    'SE',
    'PE1',
    'PE2'
);


ALTER TYPE public.run_order_type OWNER TO "ensreg-usr";

--
-- Name: run_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.run_type AS ENUM (
    'PE',
    'PE+B',
    'SE',
    'SE+B'
);


ALTER TYPE public.run_type OWNER TO "ensreg-usr";

--
-- Name: sex_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.sex_type AS ENUM (
    'female',
    'male',
    'mixed',
    'phenotypic',
    'unknown'
);


ALTER TYPE public.sex_type OWNER TO "ensreg-usr";

--
-- Name: target_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.target_type AS ENUM (
    'histone',
    'tf'
);


ALTER TYPE public.target_type OWNER TO "ensreg-usr";

--
-- Name: tf_target_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.tf_target_type AS ENUM (
    'AR',
    'ARNTL',
    'ATF4',
    'ATF7',
    'BACH1',
    'BCL6B',
    'BHLHA15',
    'CEBPB',
    'CEBPD',
    'CEBPG',
    'CLOCK',
    'CREB3',
    'CREB3L1',
    'CTCF',
    'CUX1',
    'DBP',
    'DLX4',
    'DLX6',
    'DMBX1',
    'E2F1',
    'E2F2',
    'E2F3',
    'E2F4',
    'E2F7',
    'E2F8',
    'EBF1',
    'EGR1',
    'EGR2',
    'EHF',
    'ELF1',
    'ELF2',
    'ELF3',
    'ELF4',
    'ELK1',
    'ELK3',
    'ELK4',
    'EMX1',
    'ERF',
    'ERG',
    'ESR1',
    'ESRRA',
    'ESRRB',
    'ESRRG',
    'ETS1',
    'ETS2',
    'ETV1',
    'ETV4',
    'ETV5',
    'ETV6',
    'FOS',
    'FOXA1',
    'FOXC1',
    'FOXJ2',
    'FOXJ3',
    'FOXK1',
    'FOXO1',
    'FOXO4',
    'GABPA',
    'GATA1',
    'GATA3',
    'GATA4',
    'GLI2',
    'GLIS1',
    'GLIS2',
    'GLIS3',
    'GMEB2',
    'GRHL1',
    'HES1',
    'HES2',
    'HEY1',
    'HIC2',
    'HLF',
    'HNF1A',
    'HNF1B',
    'HNF4A',
    'HOMEZ',
    'HOXA10',
    'HOXA3',
    'HOXA7',
    'HOXB13',
    'HOXB5',
    'HOXC10',
    'HOXD13',
    'HSF1',
    'HSF2',
    'HSF4',
    'IRF2',
    'IRF3',
    'IRF4',
    'IRF5',
    'IRF9',
    'ISL2',
    'ISX',
    'JDP2',
    'JUN',
    'KLF13',
    'KLF16',
    'LBX2',
    'LEF1',
    'MAFF',
    'MAFG',
    'MAFK',
    'MAX',
    'MEF2A',
    'MEF2B',
    'MEF2D',
    'MEIS1',
    'MEIS2',
    'MGA',
    'MIXL1',
    'MLX',
    'MNT',
    'MNX1',
    'MSX2',
    'MTF1',
    'MYBL2',
    'NFAT5',
    'NFATC1',
    'NFE2',
    'NFIA',
    'NFIB',
    'NFIL3',
    'NFIX',
    'NFKB2',
    'NKX3-1',
    'NR2C2',
    'NR2F1',
    'NR2F6',
    'NR3C1',
    'NRF1',
    'NRL',
    'ONECUT1',
    'ONECUT2',
    'OTX1',
    'OTX2',
    'PAX5',
    'PITX1',
    'PKNOX1',
    'POU2F1',
    'POU2F2',
    'POU5F1',
    'PRDM1',
    'PRDM4',
    'PROX1',
    'PRRX2',
    'RARA',
    'RARB',
    'RARG',
    'RFX3',
    'RFX5',
    'RORA',
    'RORB',
    'RUNX3',
    'RXRA',
    'RXRB',
    'SCRT1',
    'SCRT2',
    'SMAD3',
    'SNAI2',
    'SOX15',
    'SOX18',
    'SOX6',
    'SP1',
    'SP3',
    'SP4',
    'SPDEF',
    'SPI1',
    'SREBF2',
    'SRF',
    'SRY',
    'TBX2',
    'TBX21',
    'TBX3',
    'TCF15',
    'TCF3',
    'TCF4',
    'TEAD1',
    'TEAD3',
    'TEAD4',
    'TEF',
    'TFAP2B',
    'TFAP4',
    'TFCP2',
    'TFE3',
    'TGIF2',
    'THRA',
    'THRB',
    'TP63',
    'USF1',
    'XBP1',
    'YY1',
    'YY2',
    'ZBED1',
    'ZBTB49',
    'ZBTB7A',
    'ZBTB7B',
    'ZNF143',
    'ZNF232',
    'ZNF282',
    'ZNF713',
    'ZNF740',
    'ZNF75A',
    'ZNF784',
    'ZSCAN4'
);


ALTER TYPE public.tf_target_type OWNER TO "ensreg-usr";

--
-- Name: time_post_fertilisation_unit_type; Type: TYPE; Schema: public; Owner: ensreg-usr
--

CREATE TYPE public.time_post_fertilisation_unit_type AS ENUM (
    'day',
    'week',
    'hour'
);


ALTER TYPE public.time_post_fertilisation_unit_type OWNER TO "ensreg-usr";

--
-- Name: unnest_2d_1d(anyarray); Type: FUNCTION; Schema: public; Owner: ensreg-usr
--

CREATE FUNCTION public.unnest_2d_1d(anyarray, OUT a anyarray) RETURNS SETOF anyarray
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
BEGIN
    FOREACH a SLICE 1 IN ARRAY $1 LOOP
            RETURN NEXT;
        END LOOP;
END
$_$;


ALTER FUNCTION public.unnest_2d_1d(anyarray, OUT a anyarray) OWNER TO "ensreg-usr";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO "ensreg-usr";

--
-- Name: alignment_file; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.alignment_file (
    read_file_set_id uuid NOT NULL,
    alignment_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    assembly_id uuid NOT NULL,
    file_id uuid NOT NULL,
    alignment_task_id uuid
);


ALTER TABLE public.alignment_file OWNER TO "ensreg-usr";

--
-- Name: alignment_task; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.alignment_task (
    alignment_task_id uuid DEFAULT gen_random_uuid() NOT NULL,
    run_grouping public.run_grouping_type NOT NULL
);


ALTER TABLE public.alignment_task OWNER TO "ensreg-usr";

--
-- Name: analysis_file; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.analysis_file (
    analysis_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    assembly_id uuid NOT NULL,
    experiment_id uuid NOT NULL,
    file_id uuid NOT NULL,
    pipeline_metadata jsonb,
    analysis_type public.analysis_type NOT NULL,
    handover boolean NOT NULL
);


ALTER TABLE public.analysis_file OWNER TO "ensreg-usr";

--
-- Name: assembly; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.assembly (
    ensembl_accession character varying,
    assembly_id uuid DEFAULT gen_random_uuid() NOT NULL,
    file_id uuid NOT NULL,
    species_id uuid NOT NULL
);


ALTER TABLE public.assembly OWNER TO "ensreg-usr";

--
-- Name: atac_seq; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.atac_seq (
    experiment_id uuid NOT NULL,
    replicate_set_id uuid NOT NULL,
    library_preparation character varying
);


ALTER TABLE public.atac_seq OWNER TO "ensreg-usr";

--
-- Name: chip_seq; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.chip_seq (
    experiment_id uuid NOT NULL,
    control uuid,
    signal uuid NOT NULL,
    target_type public.target_type NOT NULL,
    histone_target_id uuid,
    tf_target_id uuid,
    library_preparation character varying
);


ALTER TABLE public.chip_seq OWNER TO "ensreg-usr";

--
-- Name: data_source; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.data_source (
    data_source_id uuid DEFAULT gen_random_uuid() NOT NULL,
    accession text NOT NULL,
    first_public date,
    last_updated date,
    archive_id uuid NOT NULL,
    request_payload jsonb,
    data_source_type public.data_source_type,
    registration_date date
);


ALTER TABLE public.data_source OWNER TO "ensreg-usr";

--
-- Name: dnase_seq; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.dnase_seq (
    experiment_id uuid NOT NULL,
    replicate_set_id uuid NOT NULL
);


ALTER TABLE public.dnase_seq OWNER TO "ensreg-usr";

--
-- Name: epigenome; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.epigenome (
    name text,
    description text,
    epigenome_id uuid DEFAULT gen_random_uuid() NOT NULL,
    epigenome_group_id uuid NOT NULL,
    species_id uuid NOT NULL,
    data_source_id uuid,
    alternative_data_source_id uuid
);


ALTER TABLE public.epigenome OWNER TO "ensreg-usr";

--
-- Name: epigenome_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.epigenome_data_source AS
 SELECT epigenome.name,
    epigenome.description,
    epigenome.epigenome_id,
    epigenome.epigenome_group_id,
    epigenome.species_id,
    epigenome.data_source_id,
    data_source.accession AS epigenome_accession
   FROM (public.epigenome
     LEFT JOIN public.data_source ON ((epigenome.data_source_id = data_source.data_source_id)));


ALTER TABLE public.epigenome_data_source OWNER TO "ensreg-usr";

--
-- Name: epigenome_group; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.epigenome_group (
    description character varying,
    epigenome_group_id uuid DEFAULT gen_random_uuid() NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.epigenome_group OWNER TO "ensreg-usr";

--
-- Name: experiment; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.experiment (
    name text,
    experiment_type public.experiment_type NOT NULL,
    epigenome_id uuid NOT NULL,
    experiment_id uuid DEFAULT gen_random_uuid() NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.experiment OWNER TO "ensreg-usr";

--
-- Name: replicate_set; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.replicate_set (
    replicate_set_id uuid DEFAULT gen_random_uuid() NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.replicate_set OWNER TO "ensreg-usr";

--
-- Name: experiment_control_target_info; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.experiment_control_target_info AS
 SELECT experiment.name,
    experiment.experiment_type,
    experiment.epigenome_id,
    experiment.experiment_id,
    experiment.data_source_id,
    replicate_set.replicate_set_id,
    'control'::text AS replicate_set_type,
    NULL::text AS experiment_target_type,
    NULL::text AS experiment_target
   FROM ((public.experiment
     JOIN public.chip_seq ON ((experiment.experiment_id = chip_seq.experiment_id)))
     JOIN public.replicate_set ON ((chip_seq.control = replicate_set.replicate_set_id)));


ALTER TABLE public.experiment_control_target_info OWNER TO "ensreg-usr";

--
-- Name: replicate_set_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.replicate_set_data_source AS
 SELECT replicate_set.replicate_set_id,
    replicate_set.data_source_id,
    data_source.accession AS replicate_set_accession
   FROM (public.replicate_set
     LEFT JOIN public.data_source ON ((replicate_set.data_source_id = data_source.data_source_id)));


ALTER TABLE public.replicate_set_data_source OWNER TO "ensreg-usr";

--
-- Name: experiment_control_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.experiment_control_data_source AS
 SELECT experiment_control_target_info.name,
    experiment_control_target_info.experiment_type,
    experiment_control_target_info.epigenome_id,
    experiment_control_target_info.experiment_id,
    experiment_control_target_info.data_source_id,
    experiment_control_target_info.replicate_set_id,
    experiment_control_target_info.replicate_set_type,
    experiment_control_target_info.experiment_target_type,
    experiment_control_target_info.experiment_target,
    replicate_set_data_source.replicate_set_accession
   FROM (public.experiment_control_target_info
     LEFT JOIN public.replicate_set_data_source ON ((experiment_control_target_info.replicate_set_id = replicate_set_data_source.replicate_set_id)));


ALTER TABLE public.experiment_control_data_source OWNER TO "ensreg-usr";

--
-- Name: histone_target; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.histone_target (
    histone_target_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name public.histone_target_type NOT NULL,
    mark_type public.mark_type NOT NULL
);


ALTER TABLE public.histone_target OWNER TO "ensreg-usr";

--
-- Name: tf_target; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.tf_target (
    tf_target_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name public.tf_target_type NOT NULL,
    gene_stable_id text
);


ALTER TABLE public.tf_target OWNER TO "ensreg-usr";

--
-- Name: experiment_signal_target_info; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.experiment_signal_target_info AS
 SELECT experiment.name,
    experiment.experiment_type,
    experiment.epigenome_id,
    experiment.experiment_id,
    experiment.data_source_id,
    replicate_set.replicate_set_id,
    'signal'::text AS replicate_set_type,
    COALESCE((chip_seq.target_type)::text, (experiment.experiment_type)::text) AS experiment_target_type,
    COALESCE((histone_target.name)::text, (tf_target.name)::text, (experiment.experiment_type)::text) AS experiment_target
   FROM ((((((public.experiment
     LEFT JOIN public.atac_seq ON ((experiment.experiment_id = atac_seq.experiment_id)))
     LEFT JOIN public.dnase_seq ON ((experiment.experiment_id = dnase_seq.experiment_id)))
     LEFT JOIN public.chip_seq ON ((experiment.experiment_id = chip_seq.experiment_id)))
     LEFT JOIN public.replicate_set ON (((atac_seq.replicate_set_id = replicate_set.replicate_set_id) OR (dnase_seq.replicate_set_id = replicate_set.replicate_set_id) OR (chip_seq.signal = replicate_set.replicate_set_id))))
     LEFT JOIN public.histone_target ON ((chip_seq.histone_target_id = histone_target.histone_target_id)))
     LEFT JOIN public.tf_target ON ((chip_seq.tf_target_id = tf_target.tf_target_id)));


ALTER TABLE public.experiment_signal_target_info OWNER TO "ensreg-usr";

--
-- Name: experiment_signal_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.experiment_signal_data_source AS
 SELECT experiment_signal_target_info.name,
    experiment_signal_target_info.experiment_type,
    experiment_signal_target_info.epigenome_id,
    experiment_signal_target_info.experiment_id,
    experiment_signal_target_info.data_source_id,
    experiment_signal_target_info.replicate_set_id,
    experiment_signal_target_info.replicate_set_type,
    experiment_signal_target_info.experiment_target_type,
    experiment_signal_target_info.experiment_target,
    replicate_set_data_source.replicate_set_accession
   FROM (public.experiment_signal_target_info
     LEFT JOIN public.replicate_set_data_source ON ((experiment_signal_target_info.replicate_set_id = replicate_set_data_source.replicate_set_id)));


ALTER TABLE public.experiment_signal_data_source OWNER TO "ensreg-usr";

--
-- Name: species; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.species (
    name text NOT NULL,
    species_id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.species OWNER TO "ensreg-usr";

--
-- Name: experiment_signal_and_control_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.experiment_signal_and_control_data_source AS
 SELECT species.name AS species_name,
    species.species_id,
    epigenome_group.description,
    epigenome_group.epigenome_group_id,
    epigenome_data_source.epigenome_accession,
    epigenome_data_source.name AS epigenome_name,
    epigenome_data_source.description AS epigenome_description,
    epigenome_data_source.epigenome_id,
    experiment_signal_data_source.name AS experiment_name,
    experiment_signal_data_source.experiment_id,
    experiment_signal_data_source.experiment_type,
    experiment_signal_data_source.experiment_target_type,
    experiment_signal_data_source.experiment_target,
    experiment_signal_data_source.replicate_set_accession AS signal_replicate_set_accession,
    experiment_signal_data_source.replicate_set_id AS signal_replicate_set_id,
    experiment_control_data_source.replicate_set_accession AS control_replicate_set_accession,
    experiment_control_data_source.replicate_set_id AS control_replicate_set_id
   FROM ((((public.species
     JOIN public.epigenome_data_source ON ((species.species_id = epigenome_data_source.species_id)))
     JOIN public.epigenome_group ON ((epigenome_data_source.epigenome_group_id = epigenome_group.epigenome_group_id)))
     JOIN public.experiment_signal_data_source ON ((epigenome_data_source.epigenome_id = experiment_signal_data_source.epigenome_id)))
     LEFT JOIN public.experiment_control_data_source ON ((experiment_signal_data_source.experiment_id = experiment_control_data_source.experiment_id)));


ALTER TABLE public.experiment_signal_and_control_data_source OWNER TO "ensreg-usr";

--
-- Name: file; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.file (
    basename text NOT NULL,
    file_type public.file_type NOT NULL,
    size bigint NOT NULL,
    md5sum text NOT NULL,
    file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    execution_metadata jsonb,
    data_source_id uuid,
    imported boolean NOT NULL,
    file_systems public.file_system_type[]
);


ALTER TABLE public.file OWNER TO "ensreg-usr";

--
-- Name: s3_object; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.s3_object (
    s3_object_id uuid DEFAULT gen_random_uuid() NOT NULL,
    key text NOT NULL,
    bucket_id uuid NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.s3_object OWNER TO "ensreg-usr";

--
-- Name: analysis_file_experiment_info; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.analysis_file_experiment_info AS
 WITH signal_files AS (
         SELECT analysis_file.analysis_file_id AS signal_analysis_file_id,
            analysis_file.experiment_id AS signal_experiment_id,
            assembly_1.assembly_id AS signal_assembly_id,
            s3_object.key AS signal_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'signal'::public.analysis_type)
        ), atac_seq_peak_files AS (
         SELECT analysis_file.analysis_file_id AS atac_seq_peak_analysis_file_id,
            analysis_file.experiment_id AS atac_seq_peak_experiment_id,
            assembly_1.assembly_id AS atac_seq_peak_assembly_id,
            s3_object.key AS atac_seq_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'atac_seq_peaks'::public.analysis_type)
        ), dnase_seq_peak_files AS (
         SELECT analysis_file.analysis_file_id AS dnase_seq_peak_analysis_file_id,
            analysis_file.experiment_id AS dnase_seq_peak_experiment_id,
            assembly_1.assembly_id AS dnase_seq_peak_assembly_id,
            s3_object.key AS dnase_seq_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'dnase_seq_peaks'::public.analysis_type)
        ), chip_seq_narrow_peak_files AS (
         SELECT analysis_file.analysis_file_id AS chip_seq_narrow_peak_analysis_file_id,
            analysis_file.experiment_id AS chip_seq_narrow_peak_experiment_id,
            assembly_1.assembly_id AS chip_seq_narrow_peak_assembly_id,
            s3_object.key AS chip_seq_narrow_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'chip_seq_narrow_peaks'::public.analysis_type)
        ), chip_seq_broad_peak_files AS (
         SELECT analysis_file.analysis_file_id AS chip_seq_broad_peak_analysis_file_id,
            analysis_file.experiment_id AS chip_seq_broad_peak_experiment_id,
            assembly_1.assembly_id AS chip_seq_broad_peak_assembly_id,
            s3_object.key AS chip_seq_broad_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'chip_seq_broad_peaks'::public.analysis_type)
        ), chip_seq_gapped_peak_files AS (
         SELECT analysis_file.analysis_file_id AS chip_seq_gapped_peak_analysis_file_id,
            analysis_file.experiment_id AS chip_seq_gapped_peak_experiment_id,
            assembly_1.assembly_id AS chip_seq_gapped_peak_assembly_id,
            s3_object.key AS chip_seq_gapped_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'chip_seq_gapped_peaks'::public.analysis_type)
        )
 SELECT experiment_signal_and_control_data_source.species_name,
    experiment_signal_and_control_data_source.species_id,
    experiment_signal_and_control_data_source.description,
    experiment_signal_and_control_data_source.epigenome_group_id,
    experiment_signal_and_control_data_source.epigenome_accession,
    experiment_signal_and_control_data_source.epigenome_name,
    experiment_signal_and_control_data_source.epigenome_description,
    experiment_signal_and_control_data_source.epigenome_id,
    experiment_signal_and_control_data_source.experiment_name,
    experiment_signal_and_control_data_source.experiment_id,
    experiment_signal_and_control_data_source.experiment_type,
    experiment_signal_and_control_data_source.experiment_target_type,
    experiment_signal_and_control_data_source.experiment_target,
    experiment_signal_and_control_data_source.signal_replicate_set_accession,
    experiment_signal_and_control_data_source.signal_replicate_set_id,
    experiment_signal_and_control_data_source.control_replicate_set_accession,
    experiment_signal_and_control_data_source.control_replicate_set_id,
    assembly.ensembl_accession,
    COALESCE(atac_seq_peak_files.atac_seq_peak_key, dnase_seq_peak_files.dnase_seq_peak_key) AS open_chromatin_peak,
    chip_seq_narrow_peak_files.chip_seq_narrow_peak_key,
    chip_seq_broad_peak_files.chip_seq_broad_peak_key,
    chip_seq_gapped_peak_files.chip_seq_gapped_peak_key,
    signal_files.signal_key
   FROM (((((((public.experiment_signal_and_control_data_source
     JOIN public.assembly ON ((experiment_signal_and_control_data_source.species_id = assembly.species_id)))
     LEFT JOIN signal_files ON (((experiment_signal_and_control_data_source.experiment_id = signal_files.signal_experiment_id) AND (signal_files.signal_assembly_id = assembly.assembly_id))))
     LEFT JOIN atac_seq_peak_files ON (((experiment_signal_and_control_data_source.experiment_id = atac_seq_peak_files.atac_seq_peak_experiment_id) AND (atac_seq_peak_files.atac_seq_peak_assembly_id = assembly.assembly_id))))
     LEFT JOIN dnase_seq_peak_files ON (((experiment_signal_and_control_data_source.experiment_id = dnase_seq_peak_files.dnase_seq_peak_experiment_id) AND (dnase_seq_peak_files.dnase_seq_peak_assembly_id = assembly.assembly_id))))
     LEFT JOIN chip_seq_narrow_peak_files ON (((experiment_signal_and_control_data_source.experiment_id = chip_seq_narrow_peak_files.chip_seq_narrow_peak_experiment_id) AND (chip_seq_narrow_peak_files.chip_seq_narrow_peak_assembly_id = assembly.assembly_id))))
     LEFT JOIN chip_seq_broad_peak_files ON (((experiment_signal_and_control_data_source.experiment_id = chip_seq_broad_peak_files.chip_seq_broad_peak_experiment_id) AND (chip_seq_broad_peak_files.chip_seq_broad_peak_assembly_id = assembly.assembly_id))))
     LEFT JOIN chip_seq_gapped_peak_files ON (((experiment_signal_and_control_data_source.experiment_id = chip_seq_gapped_peak_files.chip_seq_gapped_peak_experiment_id) AND (chip_seq_gapped_peak_files.chip_seq_gapped_peak_assembly_id = assembly.assembly_id))));


ALTER TABLE public.analysis_file_experiment_info OWNER TO "ensreg-usr";

--
-- Name: analysis_file_info_with_checks; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.analysis_file_info_with_checks AS
 SELECT analysis_file_experiment_info.species_name,
    analysis_file_experiment_info.species_id,
    analysis_file_experiment_info.description,
    analysis_file_experiment_info.epigenome_group_id,
    analysis_file_experiment_info.epigenome_accession,
    analysis_file_experiment_info.epigenome_name,
    analysis_file_experiment_info.epigenome_description,
    analysis_file_experiment_info.epigenome_id,
    analysis_file_experiment_info.experiment_name,
    analysis_file_experiment_info.experiment_id,
    analysis_file_experiment_info.experiment_type,
    analysis_file_experiment_info.experiment_target_type,
    analysis_file_experiment_info.experiment_target,
    analysis_file_experiment_info.signal_replicate_set_accession,
    analysis_file_experiment_info.signal_replicate_set_id,
    analysis_file_experiment_info.control_replicate_set_accession,
    analysis_file_experiment_info.control_replicate_set_id,
    analysis_file_experiment_info.ensembl_accession,
    analysis_file_experiment_info.open_chromatin_peak,
    analysis_file_experiment_info.chip_seq_narrow_peak_key,
    analysis_file_experiment_info.chip_seq_broad_peak_key,
    analysis_file_experiment_info.chip_seq_gapped_peak_key,
    analysis_file_experiment_info.signal_key,
        CASE
            WHEN ((analysis_file_experiment_info.experiment_type = 'chip_seq'::public.experiment_type) AND (analysis_file_experiment_info.chip_seq_narrow_peak_key IS NULL)) THEN 'Missing peaks file: ChIP-seq general case check'::text
            WHEN ((analysis_file_experiment_info.experiment_target_type = ANY (ARRAY['H3K27me3'::text, 'H3K4me1'::text])) AND ((analysis_file_experiment_info.chip_seq_narrow_peak_key IS NULL) OR (analysis_file_experiment_info.chip_seq_broad_peak_key IS NULL) OR (analysis_file_experiment_info.chip_seq_gapped_peak_key IS NULL))) THEN 'Missing some of multiple peaks files expected: ChIP-seq check for broad histone marker cases'::text
            WHEN ((analysis_file_experiment_info.experiment_target_type = ANY (ARRAY['atac_seq'::text, 'dnase_seq'::text])) AND (analysis_file_experiment_info.open_chromatin_peak IS NULL)) THEN 'Missing peaks: Open-chromatin case check'::text
            ELSE 'Ok'::text
        END AS beds_available,
        CASE
            WHEN (analysis_file_experiment_info.signal_key IS NULL) THEN 'Missing signal'::text
            ELSE 'Ok'::text
        END AS bigwig_available
   FROM public.analysis_file_experiment_info;


ALTER TABLE public.analysis_file_info_with_checks OWNER TO "ensreg-usr";

--
-- Name: archive; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.archive (
    name character varying NOT NULL,
    website character varying NOT NULL,
    archive_id uuid DEFAULT gen_random_uuid() NOT NULL,
    abbreviation character varying NOT NULL
);


ALTER TABLE public.archive OWNER TO "ensreg-usr";

--
-- Name: barcode_file; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.barcode_file (
    barcode_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    run_id uuid NOT NULL,
    file_id uuid NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.barcode_file OWNER TO "ensreg-usr";

--
-- Name: biosample; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.biosample (
    biosample_id uuid DEFAULT gen_random_uuid() NOT NULL,
    biomaterial_type public.biomaterial_type NOT NULL,
    term text NOT NULL,
    data_source_id uuid NOT NULL,
    ontology_id uuid,
    biosource_id uuid NOT NULL,
    treatments text,
    perturbed boolean,
    disease_term_id text,
    disease_term_name text,
    health_status text,
    genetic_modifications text,
    alternative_data_source_id uuid,
    organ_slims text[],
    cell_slims text[],
    developmental_slims text[],
    system_slims text[],
    synonyms text[],
    age_at_collection numrange,
    age_at_collection_unit public.age_unit_type,
    time_post_fertilisation numeric,
    time_post_fertilisation_unit public.time_post_fertilisation_unit_type,
    thermal_time numeric,
    life_stage_id uuid
);


ALTER TABLE public.biosample OWNER TO "ensreg-usr";

--
-- Name: biosample_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.biosample_data_source AS
 WITH biosample_ds AS (
         SELECT biosample_1.biosample_id,
            data_source.accession AS biosample_accession
           FROM (public.biosample biosample_1
             LEFT JOIN public.data_source ON ((biosample_1.data_source_id = data_source.data_source_id)))
        ), biosample_alternative_ds AS (
         SELECT biosample_1.biosample_id,
            data_source.accession AS biosample_alternative_accession
           FROM (public.biosample biosample_1
             LEFT JOIN public.data_source ON ((biosample_1.alternative_data_source_id = data_source.data_source_id)))
        )
 SELECT biosample.biosample_id,
    biosample.biomaterial_type,
    biosample.term,
    biosample.data_source_id,
    biosample.ontology_id,
    biosample.biosource_id,
    biosample.treatments,
    biosample.perturbed,
    biosample.disease_term_id,
    biosample.disease_term_name,
    biosample.health_status,
    biosample.genetic_modifications,
    biosample.alternative_data_source_id,
    biosample.organ_slims,
    biosample.cell_slims,
    biosample.developmental_slims,
    biosample.system_slims,
    biosample.synonyms,
    biosample.age_at_collection,
    biosample.age_at_collection_unit,
    biosample.time_post_fertilisation,
    biosample.time_post_fertilisation_unit,
    biosample.thermal_time,
    biosample.life_stage_id,
    biosample_ds.biosample_accession,
    biosample_alternative_ds.biosample_alternative_accession
   FROM ((public.biosample
     LEFT JOIN biosample_ds ON ((biosample.biosample_id = biosample_ds.biosample_id)))
     LEFT JOIN biosample_alternative_ds ON ((biosample.biosample_id = biosample_alternative_ds.biosample_id)));


ALTER TABLE public.biosample_data_source OWNER TO "ensreg-usr";

--
-- Name: biosample_set; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.biosample_set (
    biosample_set_id uuid DEFAULT gen_random_uuid() NOT NULL,
    biosample_set_type public.biosample_set_type NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.biosample_set OWNER TO "ensreg-usr";

--
-- Name: biosample_set_biosample; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.biosample_set_biosample (
    biosample_set_id uuid NOT NULL,
    biosample_id uuid NOT NULL
);


ALTER TABLE public.biosample_set_biosample OWNER TO "ensreg-usr";

--
-- Name: biosample_set_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.biosample_set_data_source AS
 SELECT biosample_set.biosample_set_id,
    biosample_set.biosample_set_type,
    biosample_set.data_source_id,
    data_source.accession
   FROM (public.biosample_set
     LEFT JOIN public.data_source ON ((biosample_set.data_source_id = data_source.data_source_id)));


ALTER TABLE public.biosample_set_data_source OWNER TO "ensreg-usr";

--
-- Name: biosource; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.biosource (
    biosource_id uuid DEFAULT gen_random_uuid() NOT NULL,
    sex public.sex_type NOT NULL,
    age_unit public.age_unit_type,
    data_source_id uuid,
    age numrange,
    alternative_data_source_id uuid,
    life_stage_id uuid
);


ALTER TABLE public.biosource OWNER TO "ensreg-usr";

--
-- Name: biosource_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.biosource_data_source AS
 WITH biosource_ds AS (
         SELECT biosource_1.biosource_id,
            data_source.accession AS biosource_accession
           FROM (public.biosource biosource_1
             LEFT JOIN public.data_source ON ((biosource_1.data_source_id = data_source.data_source_id)))
        ), biosource_alternative_ds AS (
         SELECT biosource_1.biosource_id,
            data_source.accession AS biosource_alternative_accession
           FROM (public.biosource biosource_1
             LEFT JOIN public.data_source ON ((biosource_1.alternative_data_source_id = data_source.data_source_id)))
        )
 SELECT biosource.biosource_id,
    biosource.sex,
    biosource.age_unit,
    biosource.data_source_id,
    biosource.age,
    biosource.alternative_data_source_id,
    biosource.life_stage_id,
    biosource_ds.biosource_accession,
    biosource_alternative_ds.biosource_alternative_accession
   FROM ((public.biosource
     LEFT JOIN biosource_ds ON ((biosource.biosource_id = biosource_ds.biosource_id)))
     LEFT JOIN biosource_alternative_ds ON ((biosource.biosource_id = biosource_alternative_ds.biosource_id)));


ALTER TABLE public.biosource_data_source OWNER TO "ensreg-usr";

--
-- Name: experiment_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.experiment_data_source AS
 SELECT experiment_signal_data_source.name,
    experiment_signal_data_source.experiment_type,
    experiment_signal_data_source.epigenome_id,
    experiment_signal_data_source.experiment_id,
    experiment_signal_data_source.data_source_id,
    experiment_signal_data_source.replicate_set_id,
    experiment_signal_data_source.replicate_set_type,
    experiment_signal_data_source.experiment_target_type,
    experiment_signal_data_source.experiment_target,
    experiment_signal_data_source.replicate_set_accession
   FROM public.experiment_signal_data_source
UNION ALL
 SELECT experiment_control_data_source.name,
    experiment_control_data_source.experiment_type,
    experiment_control_data_source.epigenome_id,
    experiment_control_data_source.experiment_id,
    experiment_control_data_source.data_source_id,
    experiment_control_data_source.replicate_set_id,
    experiment_control_data_source.replicate_set_type,
    experiment_control_data_source.experiment_target_type,
    experiment_control_data_source.experiment_target,
    experiment_control_data_source.replicate_set_accession
   FROM public.experiment_control_data_source;


ALTER TABLE public.experiment_data_source OWNER TO "ensreg-usr";

--
-- Name: life_stage; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.life_stage (
    life_stage_id uuid DEFAULT gen_random_uuid() NOT NULL,
    term text NOT NULL,
    ontology_relation public.ontology_relation_type NOT NULL,
    ontology_id uuid NOT NULL
);


ALTER TABLE public.life_stage OWNER TO "ensreg-usr";

--
-- Name: ontology; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.ontology (
    ontology_id uuid DEFAULT gen_random_uuid() NOT NULL,
    ontology_type public.ontology_type NOT NULL,
    curie text NOT NULL
);


ALTER TABLE public.ontology OWNER TO "ensreg-usr";

--
-- Name: life_stage_with_ontology; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.life_stage_with_ontology AS
 SELECT life_stage.life_stage_id,
    life_stage.term AS life_stage_term,
    life_stage.ontology_relation AS life_stage_ontology_relation,
    life_stage.ontology_id AS life_stage_ontology_id,
    ontology.ontology_type AS life_stage_ontology_type,
    ontology.curie AS life_stage_ontology_curie
   FROM (public.life_stage
     JOIN public.ontology ON ((life_stage.ontology_id = ontology.ontology_id)));


ALTER TABLE public.life_stage_with_ontology OWNER TO "ensreg-usr";

--
-- Name: replicate; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.replicate (
    read_file_set_id uuid NOT NULL,
    replicate_id uuid DEFAULT gen_random_uuid() NOT NULL,
    replicate_set_id uuid NOT NULL,
    data_source_id uuid,
    biosample_set_id uuid
);


ALTER TABLE public.replicate OWNER TO "ensreg-usr";

--
-- Name: replicate_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.replicate_data_source AS
 SELECT replicate.read_file_set_id,
    replicate.replicate_id,
    replicate.replicate_set_id,
    replicate.data_source_id,
    replicate.biosample_set_id,
    data_source.accession AS replicate_accession
   FROM (public.replicate
     LEFT JOIN public.data_source ON ((replicate.data_source_id = data_source.data_source_id)));


ALTER TABLE public.replicate_data_source OWNER TO "ensreg-usr";

--
-- Name: experiment_metadata; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.experiment_metadata AS
 SELECT species.name AS species_name,
    species.species_id,
    epigenome_group.description AS epigenome_group_description,
    epigenome_group.epigenome_group_id,
    epigenome_data_source.epigenome_accession,
    epigenome_data_source.name AS epigenome_name,
    epigenome_data_source.description AS epigenome_description,
    experiment_data_source.name,
    experiment_data_source.experiment_type,
    experiment_data_source.epigenome_id,
    experiment_data_source.experiment_id,
    experiment_data_source.data_source_id,
    experiment_data_source.replicate_set_id,
    experiment_data_source.replicate_set_type,
    experiment_data_source.experiment_target_type,
    experiment_data_source.experiment_target,
    experiment_data_source.replicate_set_accession,
    replicate_data_source.replicate_id,
    replicate_data_source.replicate_accession,
    replicate_data_source.biosample_set_id,
    biosample_set_data_source.biosample_set_type,
    biosample_set_data_source.accession,
    biosample_data_source.biosample_id,
    biosample_data_source.biosample_accession,
    biosample_data_source.biosample_alternative_accession,
    biosample_data_source.biomaterial_type,
    biosample_data_source.term AS biosample_term,
    biosample_data_source.ontology_id,
    ontology.ontology_type,
    ontology.curie,
    biosample_data_source.organ_slims,
    biosample_data_source.cell_slims,
    biosample_data_source.developmental_slims,
    biosample_data_source.system_slims,
    biosample_data_source.synonyms,
    life_stage_with_ontology.life_stage_id,
    life_stage_with_ontology.life_stage_term,
    life_stage_with_ontology.life_stage_ontology_relation,
    life_stage_with_ontology.life_stage_ontology_id,
    life_stage_with_ontology.life_stage_ontology_type,
    life_stage_with_ontology.life_stage_ontology_curie,
    biosample_data_source.age_at_collection,
    biosample_data_source.age_at_collection_unit,
    biosample_data_source.time_post_fertilisation,
    biosample_data_source.time_post_fertilisation_unit,
    biosample_data_source.thermal_time,
    biosample_data_source.perturbed,
    biosample_data_source.treatments,
    biosample_data_source.health_status,
    biosample_data_source.disease_term_id,
    biosample_data_source.disease_term_name,
    biosample_data_source.genetic_modifications,
    biosource_data_source.biosource_accession,
    biosource_data_source.biosource_alternative_accession,
    biosource_data_source.age,
    biosource_data_source.age_unit,
    biosource_data_source.sex,
    assembly.ensembl_accession AS assembly_name,
    assembly.assembly_id
   FROM ((((((((((((public.species
     JOIN public.assembly ON ((species.species_id = assembly.species_id)))
     JOIN public.epigenome_data_source ON ((species.species_id = epigenome_data_source.species_id)))
     JOIN public.epigenome_group ON ((epigenome_data_source.epigenome_group_id = epigenome_group.epigenome_group_id)))
     JOIN public.experiment_data_source ON ((epigenome_data_source.epigenome_id = experiment_data_source.epigenome_id)))
     JOIN public.replicate_set ON ((experiment_data_source.replicate_set_id = replicate_set.replicate_set_id)))
     JOIN public.replicate_data_source ON ((replicate_set.replicate_set_id = replicate_data_source.replicate_set_id)))
     LEFT JOIN public.biosample_set_data_source ON ((replicate_data_source.biosample_set_id = biosample_set_data_source.biosample_set_id)))
     LEFT JOIN public.biosample_set_biosample ON ((biosample_set_data_source.biosample_set_id = biosample_set_biosample.biosample_set_id)))
     LEFT JOIN public.biosample_data_source ON ((biosample_set_biosample.biosample_id = biosample_data_source.biosample_id)))
     LEFT JOIN public.ontology ON ((biosample_data_source.ontology_id = ontology.ontology_id)))
     LEFT JOIN public.biosource_data_source ON ((biosample_data_source.biosource_id = biosource_data_source.biosource_id)))
     LEFT JOIN public.life_stage_with_ontology ON (((biosample_data_source.life_stage_id = life_stage_with_ontology.life_stage_id) OR (biosource_data_source.life_stage_id = life_stage_with_ontology.life_stage_id))));


ALTER TABLE public.experiment_metadata OWNER TO "ensreg-usr";

--
-- Name: curated_experiment_metadata; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.curated_experiment_metadata AS
 SELECT DISTINCT experiment_metadata.species_name,
    experiment_metadata.epigenome_name,
    experiment_metadata.name,
    COALESCE(experiment_metadata.accession, experiment_metadata.biosample_accession) AS biosample_accession,
    initcap(replace((experiment_metadata.biomaterial_type)::text, '_'::text, ' '::text)) AS material,
        CASE
            WHEN (experiment_metadata.biosample_term = ANY (ARRAY['Thymus'::text, 'Uterus'::text])) THEN lower(experiment_metadata.biosample_term)
            ELSE experiment_metadata.biosample_term
        END AS term,
    concat(experiment_metadata.ontology_type, '_', experiment_metadata.curie) AS term_ontology,
    experiment_metadata.organ_slims,
    experiment_metadata.system_slims,
        CASE
            WHEN (experiment_metadata.experiment_type = 'atac_seq'::public.experiment_type) THEN 'ATAC-seq'::text
            WHEN (experiment_metadata.experiment_type = 'dnase_seq'::public.experiment_type) THEN 'DNase-seq'::text
            WHEN (experiment_metadata.experiment_type = 'chip_seq'::public.experiment_type) THEN 'ChIP-seq'::text
            ELSE NULL::text
        END AS experiment_type,
        CASE
            WHEN (experiment_metadata.experiment_target_type = 'atac_seq'::text) THEN 'open chromatin'::text
            WHEN (experiment_metadata.experiment_target_type = 'dnase_seq'::text) THEN 'open chromatin'::text
            WHEN (experiment_metadata.experiment_target_type = 'tf'::text) THEN 'transcription factor'::text
            WHEN (experiment_metadata.experiment_target_type = 'histone'::text) THEN 'histone'::text
            ELSE NULL::text
        END AS experiment_target_type,
        CASE
            WHEN ((experiment_metadata.experiment_target = 'atac_seq'::text) OR (experiment_metadata.experiment_target = 'dnase_seq'::text)) THEN 'open chromatin'::text
            ELSE experiment_metadata.experiment_target
        END AS experiment_target,
    experiment_metadata.sex,
    COALESCE(experiment_metadata.life_stage_term, 'unknown'::text) AS life_stage,
        CASE
            WHEN (experiment_metadata.thermal_time IS NOT NULL) THEN (round(experiment_metadata.thermal_time, 2))::text
            WHEN (lower(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)) = upper(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age))) THEN (lower(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)))::text
            WHEN (lower(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)) <> upper(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age))) THEN concat(lower(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)), '-', upper(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)))
            ELSE 'unknown'::text
        END AS age,
        CASE
            WHEN (experiment_metadata.thermal_time IS NOT NULL) THEN 'thermal time'::text
            ELSE (COALESCE(experiment_metadata.age_at_collection_unit, experiment_metadata.age_unit))::text
        END AS age_unit,
    COALESCE(experiment_metadata.replicate_set_accession, experiment_metadata.replicate_accession) AS data_source,
    experiment_metadata.assembly_name,
    experiment_metadata.experiment_id,
    experiment_metadata.epigenome_id,
    experiment_metadata.epigenome_description,
    experiment_metadata.cell_slims,
    experiment_metadata.species_id,
    experiment_metadata.assembly_id
   FROM (public.experiment_metadata
     JOIN public.analysis_file ON (((experiment_metadata.experiment_id = analysis_file.experiment_id) AND (analysis_file.assembly_id = experiment_metadata.assembly_id))))
  WHERE ((analysis_file.handover = true) AND (experiment_metadata.replicate_set_type = 'signal'::text) AND (analysis_file.analysis_type = ANY (ARRAY['chip_seq_broad_peaks'::public.analysis_type, 'chip_seq_gapped_peaks'::public.analysis_type, 'chip_seq_narrow_peaks'::public.analysis_type, 'dnase_seq_peaks'::public.analysis_type, 'atac_seq_peaks'::public.analysis_type])) AND (experiment_metadata.biomaterial_type IS NOT NULL));


ALTER TABLE public.curated_experiment_metadata OWNER TO "ensreg-usr";

--
-- Name: base_epigenome_replicates; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.base_epigenome_replicates AS
 WITH metadata_epig_expr_with_ids AS (
         SELECT DISTINCT me_1.epigenome_id,
            me_1.experiment_type,
            me_1.experiment_target,
            me_1.data_source,
            me_1.biosample_accession,
            array_agg(DISTINCT me_1.material) AS material,
            me_1.term,
            me_1.term_ontology,
            array_agg(DISTINCT me_1.sex) AS sex,
            array_agg(DISTINCT me_1.life_stage) AS life_stage,
            array_agg(DISTINCT me_1.age ORDER BY me_1.age) AS age,
            array_agg(DISTINCT me_1.age_unit) AS age_unit,
            me_1.species_name,
            me_1.assembly_name
           FROM public.curated_experiment_metadata me_1
          WHERE (me_1.term <> 'iPS-18c'::text)
          GROUP BY me_1.epigenome_id, me_1.term, me_1.term_ontology, me_1.experiment_type, me_1.experiment_target, me_1.data_source, me_1.biosample_accession, me_1.species_name, me_1.assembly_name
        ), age_n_sex_preprocessing AS (
         SELECT metadata_epig_expr_with_ids.epigenome_id,
            metadata_epig_expr_with_ids.experiment_type,
            metadata_epig_expr_with_ids.experiment_target,
            metadata_epig_expr_with_ids.data_source,
            metadata_epig_expr_with_ids.biosample_accession,
            metadata_epig_expr_with_ids.material,
            metadata_epig_expr_with_ids.term,
            metadata_epig_expr_with_ids.term_ontology,
            metadata_epig_expr_with_ids.sex,
            metadata_epig_expr_with_ids.life_stage,
            metadata_epig_expr_with_ids.age,
            metadata_epig_expr_with_ids.age_unit,
            metadata_epig_expr_with_ids.species_name,
            metadata_epig_expr_with_ids.assembly_name,
            ARRAY( SELECT unnest(
                        CASE
                            WHEN ('unknown'::text = ANY (metadata_epig_expr_with_ids.age)) THEN NULL::numeric[]
                            ELSE (metadata_epig_expr_with_ids.age)::numeric[]
                        END) AS unnest
                  ORDER BY (unnest(
                        CASE
                            WHEN ('unknown'::text = ANY (metadata_epig_expr_with_ids.age)) THEN NULL::numeric[]
                            ELSE (metadata_epig_expr_with_ids.age)::numeric[]
                        END))) AS age_sorted,
                CASE
                    WHEN ('unknown'::text = ANY (metadata_epig_expr_with_ids.age)) THEN NULL::text
                    WHEN ((('embryo'::text = ANY (metadata_epig_expr_with_ids.life_stage)) OR ('embryonic'::text = ANY (metadata_epig_expr_with_ids.life_stage))) AND ('day'::text = ANY (metadata_epig_expr_with_ids.age_unit))) THEN 'days post fertilisation'::text
                    ELSE array_to_string(metadata_epig_expr_with_ids.age_unit, ', '::text)
                END AS age_unit_processed,
                CASE
                    WHEN ((metadata_epig_expr_with_ids.sex)::text[] @> ARRAY['unknown'::text]) THEN NULL::text
                    WHEN ((metadata_epig_expr_with_ids.sex)::text[] @> ARRAY['mixed'::text]) THEN NULL::text
                    WHEN ((metadata_epig_expr_with_ids.sex)::text[] @> ARRAY['male'::text, 'female'::text]) THEN NULL::text
                    WHEN ((metadata_epig_expr_with_ids.sex)::text[] = ARRAY['male'::text]) THEN 'm'::text
                    WHEN ((metadata_epig_expr_with_ids.sex)::text[] = ARRAY['female'::text]) THEN 'f'::text
                    WHEN ((metadata_epig_expr_with_ids.sex)::text[] = ARRAY['phenotypic'::text]) THEN NULL::text
                    ELSE 'Err: not contemplated case'::text
                END AS sex_for_label
           FROM metadata_epig_expr_with_ids
        )
 SELECT asp.species_name,
    asp.assembly_name,
    asp.epigenome_id AS base_epigenome_id,
    lower(array_to_string(asp.material, ', '::text)) AS material,
    asp.term,
        CASE
            WHEN (asp.term <> 'embryo'::text) THEN asp.term
            ELSE NULL::text
        END AS term_for_label,
    asp.term_ontology,
    array_to_string(asp.sex, ', '::text) AS sex,
    asp.sex_for_label,
    array_to_string(asp.life_stage, ', '::text) AS life_stage,
        CASE
            WHEN (((asp.sex)::text[] @> ARRAY['phenotypic'::text, 'unknown'::text]) AND (asp.term = 'embryo'::text)) THEN array_to_string(asp.life_stage, ', '::text)
            ELSE NULL::text
        END AS life_stage_for_label,
        CASE
            WHEN (array_length(asp.age_sorted, 1) = 1) THEN ((asp.age_sorted[1])::real)::text
            ELSE NULL::text
        END AS age_value,
    array_to_string(asp.age_unit, ', '::text) AS age_unit,
        CASE
            WHEN ((asp.age_unit_processed <> ALL (ARRAY['days post fertilisation'::text, 'thermal time'::text])) AND (asp.age_sorted[1] <> (1)::numeric)) THEN concat(asp.age_unit_processed, 's')
            ELSE asp.age_unit_processed
        END AS modified_age_unit,
        CASE
            WHEN (array_length(asp.age_sorted, 1) = 1) THEN concat(((asp.age_sorted[1])::real)::text, ' ',
            CASE
                WHEN ((asp.age_unit_processed <> ALL (ARRAY['days post fertilisation'::text, 'thermal time'::text])) AND (asp.age_sorted[1] <> (1)::numeric)) THEN concat(asp.age_unit_processed, 's')
                ELSE asp.age_unit_processed
            END)
            ELSE NULL::text
        END AS extended_age,
    ((
        CASE
            WHEN (array_length(asp.age_sorted, 1) IS NULL) THEN NULL::text
            WHEN (array_length(asp.age_sorted, 1) = 1) THEN ((asp.age_sorted[1])::real)::text
            ELSE concat(((asp.age_sorted[1])::real)::text, '-', ((asp.age_sorted[array_upper(asp.age_sorted, 1)])::real)::text)
        END || ' '::text) ||
        CASE asp.age_unit_processed
            WHEN 'days post fertilisation'::text THEN 'dpf'::text
            WHEN 'month'::text THEN 'mo'::text
            WHEN 'year'::text THEN 'y'::text
            WHEN 'week'::text THEN 'w'::text
            WHEN 'day'::text THEN 'd'::text
            WHEN 'thermal time'::text THEN 'tt'::text
            ELSE asp.age_unit_processed
        END) AS short_age,
        CASE
            WHEN (array_length(asp.age_sorted, 1) IS NULL) THEN NULL::text
            WHEN (((asp.assembly_name)::text = 'GRCm39'::text) AND (array_to_string(asp.life_stage, ', '::text) = 'embryonic'::text)) THEN concat('E',
            CASE
                WHEN (array_length(asp.age_sorted, 1) = 1) THEN ((asp.age_sorted[1])::real)::text
                ELSE concat(((asp.age_sorted[1])::real)::text, '-', ((asp.age_sorted[array_upper(asp.age_sorted, 1)])::real)::text)
            END)
            ELSE ((
            CASE
                WHEN (array_length(asp.age_sorted, 1) IS NULL) THEN NULL::text
                WHEN (array_length(asp.age_sorted, 1) = 1) THEN ((asp.age_sorted[1])::real)::text
                ELSE concat(((asp.age_sorted[1])::real)::text, '-', ((asp.age_sorted[array_upper(asp.age_sorted, 1)])::real)::text)
            END || ' '::text) ||
            CASE asp.age_unit_processed
                WHEN 'days post fertilisation'::text THEN 'dpf'::text
                WHEN 'month'::text THEN 'mo'::text
                WHEN 'year'::text THEN 'y'::text
                WHEN 'week'::text THEN 'w'::text
                WHEN 'day'::text THEN 'd'::text
                WHEN 'thermal time'::text THEN 'tt'::text
                ELSE asp.age_unit_processed
            END)
        END AS age_for_label,
    asp.experiment_type,
    asp.experiment_target,
    asp.biosample_accession,
    asp.data_source
   FROM age_n_sex_preprocessing asp;


ALTER TABLE public.base_epigenome_replicates OWNER TO "ensreg-usr";

--
-- Name: biosample_biological_group; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.biosample_biological_group AS
 WITH classified AS (
         SELECT metadata.epigenome_id,
                CASE lower(metadata.material)
                    WHEN 'cell line'::text THEN
                    CASE
                        WHEN (metadata.term = ANY (ARRAY['K562'::text, 'MEL'::text])) THEN 'blood and myeloid'::text
                        WHEN (metadata.term = 'SK-N-SH'::text) THEN 'brain and nervous system'::text
                        WHEN (metadata.term = ANY (ARRAY['Caco-2'::text, 'HCT116'::text])) THEN 'intestine'::text
                        WHEN (metadata.term = 'HEK293'::text) THEN 'kidney'::text
                        WHEN (metadata.term = ANY (ARRAY['A549'::text, 'PC-9'::text])) THEN 'lung'::text
                        WHEN (metadata.term = ANY (ARRAY['CH12.LX'::text, 'DND-41'::text, 'DOHH2'::text, 'GM06990'::text, 'GM12878'::text, 'KMS-11'::text, 'KOPT-K1'::text, 'Karpas-422'::text, 'Loucy'::text, 'MM.1S'::text, 'NCI-H929'::text, 'OCI-LY1'::text, 'OCI-LY3'::text, 'OCI-LY7'::text, 'SU-DHL-6'::text])) THEN 'lymphoid'::text
                        WHEN (metadata.term = 'MCF-7'::text) THEN 'mammary gland'::text
                        WHEN (metadata.term = ANY (ARRAY['A673'::text, 'AG04450'::text, 'BJ'::text, 'GM23248'::text, 'IMR-90'::text, 'SK-N-MC'::text])) THEN 'mesenchymal and fibroblast'::text
                        WHEN (metadata.term = 'Panc1'::text) THEN 'pancreas'::text
                        WHEN (metadata.term = ANY (ARRAY['ES-Bruce4'::text, 'ES-E14'::text, 'ES-I3'::text, 'GM23338'::text, 'H1'::text, 'H7'::text, 'H9'::text, 'HUES48'::text, 'HUES6'::text, 'HUES64'::text, 'NT2/D1'::text, 'iPS DF 19.11'::text, 'iPS DF 6.9'::text, 'iPS-18a'::text, 'iPS-20b'::text])) THEN 'pluripotent cells and models'::text
                        WHEN (metadata.term = 'PC-3'::text) THEN 'prostate gland'::text
                        WHEN (metadata.term = 'ACC112'::text) THEN 'salivary gland'::text
                        WHEN (metadata.term = 'HeLa-S3'::text) THEN 'uterus'::text
                        ELSE NULL::text
                    END
                    WHEN 'primary cell'::text THEN
                    CASE
                        WHEN (metadata.term = ANY (ARRAY['CD14-positive monocyte'::text, 'bone marrow macrophage'::text, 'common myeloid progenitor, CD34-positive'::text, 'mononuclear cell'::text, 'neutrophil'::text])) THEN 'blood and myeloid'::text
                        WHEN (metadata.term = 'astrocyte'::text) THEN 'brain and nervous system'::text
                        WHEN (metadata.term = 'kidney epithelial cell'::text) THEN 'kidney'::text
                        WHEN (metadata.term = 'bronchial epithelial cell'::text) THEN 'lung'::text
                        WHEN (metadata.term = ANY (ARRAY['B cell'::text, 'T-cell'::text, 'natural killer cell'::text])) THEN 'lymphoid'::text
                        WHEN (metadata.term = 'mammary epithelial cell'::text) THEN 'mammary gland'::text
                        WHEN (metadata.term = ANY (ARRAY['embryonic fibroblast'::text, 'fibroblast of dermis'::text, 'fibroblast of lung'::text, 'fibroblast of mammary gland'::text, 'foreskin fibroblast'::text, 'osteoblast'::text])) THEN 'mesenchymal and fibroblast'::text
                        WHEN (metadata.term = 'skeletal muscle myoblast'::text) THEN 'musculature'::text
                        WHEN (metadata.term = 'keratinocyte'::text) THEN 'skin'::text
                        WHEN (metadata.term = 'endothelial cell of umbilical vein'::text) THEN 'vasculature'::text
                        ELSE NULL::text
                    END
                    WHEN 'primary cell culture'::text THEN
                    CASE
                        WHEN (metadata.term = ANY (ARRAY['neural cell'::text, 'neural progenitor cell'::text, 'neuron'::text, 'neuronal stem cell'::text])) THEN 'brain and nervous system'::text
                        WHEN (metadata.term = ANY (ARRAY['ectodermal cell'::text, 'endodermal cell'::text, 'mesendoderm'::text, 'mesodermal cell'::text])) THEN 'embryo'::text
                        WHEN (metadata.term = 'cardiac muscle cell'::text) THEN 'heart'::text
                        WHEN (metadata.term = 'hepatocyte'::text) THEN 'liver'::text
                        WHEN (metadata.term = 'mesenchymal stem cell'::text) THEN 'mesenchymal and fibroblast'::text
                        WHEN (metadata.term = ANY (ARRAY['myotube'::text, 'smooth muscle cell'::text])) THEN 'musculature'::text
                        WHEN (metadata.term = 'trophoblast cell'::text) THEN 'placenta'::text
                        ELSE NULL::text
                    END
                    WHEN 'primary tissue'::text THEN
                    CASE
                        WHEN (metadata.term = ANY (ARRAY['adipose tissue'::text, 'brown adipose tissue'::text, 'subcutaneous adipose tissue'::text])) THEN 'adipose tissue'::text
                        WHEN (metadata.term = 'adrenal gland'::text) THEN 'adrenal gland'::text
                        WHEN (metadata.term = 'bone marrow'::text) THEN 'blood and myeloid'::text
                        WHEN (metadata.term = ANY (ARRAY['brain'::text, 'cerebellum'::text, 'cortex'::text, 'cortical plate'::text, 'forebrain'::text, 'frontal cortex'::text, 'hindbrain'::text, 'hypothalamus'::text, 'midbrain'::text, 'neural tube'::text, 'olfactory bulb'::text, 'tibial nerve'::text])) THEN 'brain and nervous system'::text
                        WHEN (metadata.term = ANY (ARRAY['embryo'::text, 'embryonic facial prominence'::text, 'limb'::text])) THEN 'embryo'::text
                        WHEN (metadata.term = ANY (ARRAY['esophagus muscularis mucosa'::text, 'esophagus squamous epithelium'::text])) THEN 'esophagus'::text
                        WHEN (metadata.term = 'gill filament'::text) THEN 'gill'::text
                        WHEN (metadata.term = ANY (ARRAY['gonad'::text, 'immature gonad'::text, 'testis'::text])) THEN 'gonad'::text
                        WHEN (metadata.term = ANY (ARRAY['heart'::text, 'heart left ventricle'::text, 'right atrium auricular region'::text])) THEN 'heart'::text
                        WHEN (metadata.term = ANY (ARRAY['Peyer''s patch'::text, 'ileum'::text, 'intestine'::text, 'large intestine'::text, 'sigmoid colon'::text, 'small intestine'::text, 'transverse colon'::text])) THEN 'intestine'::text
                        WHEN (metadata.term = ANY (ARRAY['kidney'::text, 'mesonephros'::text])) THEN 'kidney'::text
                        WHEN (metadata.term = ANY (ARRAY['liver'::text, 'lobe of liver'::text, 'right lobe of liver'::text])) THEN 'liver'::text
                        WHEN (metadata.term = ANY (ARRAY['left lung lobe'::text, 'lung'::text, 'upper lobe of left lung'::text])) THEN 'lung'::text
                        WHEN (metadata.term = 'breast epithelium'::text) THEN 'mammary gland'::text
                        WHEN (metadata.term = ANY (ARRAY['fast muscle tissue'::text, 'gastrocnemius medialis'::text, 'gluteus medius'::text, 'hindlimb muscle'::text, 'longissimus dorsi muscle'::text, 'muscle of leg'::text, 'muscle of trunk'::text, 'psoas muscle'::text, 'skeletal muscle tissue'::text])) THEN 'musculature'::text
                        WHEN (metadata.term = 'body of pancreas'::text) THEN 'pancreas'::text
                        WHEN (metadata.term = 'placenta'::text) THEN 'placenta'::text
                        WHEN (metadata.term = 'prostate gland'::text) THEN 'prostate gland'::text
                        WHEN (metadata.term = ANY (ARRAY['skin of back'::text, 'skin of body'::text])) THEN 'skin'::text
                        WHEN (metadata.term = 'spleen'::text) THEN 'spleen'::text
                        WHEN (metadata.term = ANY (ARRAY['gastroesophageal sphincter'::text, 'stomach'::text])) THEN 'stomach'::text
                        WHEN (metadata.term = 'thymus'::text) THEN 'thymus'::text
                        WHEN (metadata.term = 'thyroid gland'::text) THEN 'thyroid gland'::text
                        WHEN (metadata.term = 'trachea'::text) THEN 'trachea'::text
                        WHEN (metadata.term = 'uterus'::text) THEN 'uterus'::text
                        WHEN (metadata.term = 'vagina'::text) THEN 'vagina'::text
                        WHEN (metadata.term = ANY (ARRAY['ascending aorta'::text, 'thoracic aorta'::text, 'tibial artery'::text])) THEN 'vasculature'::text
                        ELSE NULL::text
                    END
                    ELSE NULL::text
                END AS biological_group
           FROM public.curated_experiment_metadata metadata
        )
 SELECT classified.epigenome_id,
        CASE
            WHEN (count(DISTINCT classified.biological_group) = 1) THEN min(classified.biological_group)
            ELSE NULL::text
        END AS biological_group
   FROM classified
  GROUP BY classified.epigenome_id;


ALTER TABLE public.biosample_biological_group OWNER TO "ensreg-usr";

--
-- Name: biosample_sample_type; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.biosample_sample_type AS
 WITH classified AS (
         SELECT metadata.epigenome_id,
                CASE lower(metadata.material)
                    WHEN 'cell line'::text THEN
                    CASE
                        WHEN (metadata.term = ANY (ARRAY['A549'::text, 'A673'::text, 'CH12.LX'::text, 'Caco-2'::text, 'DND-41'::text, 'DOHH2'::text, 'HCT116'::text, 'HeLa-S3'::text, 'K562'::text, 'KMS-11'::text, 'KOPT-K1'::text, 'Karpas-422'::text, 'Loucy'::text, 'MCF-7'::text, 'MEL'::text, 'MM.1S'::text, 'NCI-H929'::text, 'NT2/D1'::text, 'OCI-LY1'::text, 'OCI-LY3'::text, 'OCI-LY7'::text, 'PC-3'::text, 'PC-9'::text, 'Panc1'::text, 'SK-N-MC'::text, 'SK-N-SH'::text, 'SU-DHL-6'::text])) THEN 'Cancer cell line'::text
                        WHEN (metadata.term = ANY (ARRAY['ES-Bruce4'::text, 'ES-E14'::text, 'ES-I3'::text, 'H1'::text, 'H7'::text, 'H9'::text, 'HUES48'::text, 'HUES6'::text, 'HUES64'::text])) THEN 'Embryonic stem cell line'::text
                        WHEN (metadata.term = ANY (ARRAY['AG04450'::text, 'BJ'::text, 'GM23248'::text, 'IMR-90'::text])) THEN 'Finite cell line'::text
                        WHEN (metadata.term = ANY (ARRAY['GM23338'::text, 'iPS DF 19.11'::text, 'iPS DF 6.9'::text, 'iPS-18a'::text, 'iPS-20b'::text])) THEN 'Induced pluripotent stem cell line'::text
                        WHEN (metadata.term = ANY (ARRAY['ACC112'::text, 'GM06990'::text, 'GM12878'::text, 'HEK293'::text])) THEN 'Transformed cell line'::text
                        ELSE NULL::text
                    END
                    WHEN 'primary cell'::text THEN
                    CASE
                        WHEN (metadata.term = ANY (ARRAY['B cell'::text, 'CD14-positive monocyte'::text, 'T-cell'::text, 'astrocyte'::text, 'bone marrow macrophage'::text, 'bronchial epithelial cell'::text, 'common myeloid progenitor, CD34-positive'::text, 'embryonic fibroblast'::text, 'endothelial cell of umbilical vein'::text, 'fibroblast of dermis'::text, 'fibroblast of lung'::text, 'fibroblast of mammary gland'::text, 'foreskin fibroblast'::text, 'keratinocyte'::text, 'kidney epithelial cell'::text, 'mammary epithelial cell'::text, 'mononuclear cell'::text, 'natural killer cell'::text, 'neutrophil'::text, 'osteoblast'::text, 'skeletal muscle myoblast'::text])) THEN 'Primary cells'::text
                        ELSE NULL::text
                    END
                    WHEN 'primary cell culture'::text THEN
                    CASE
                        WHEN (metadata.term = ANY (ARRAY['cardiac muscle cell'::text, 'ectodermal cell'::text, 'endodermal cell'::text, 'hepatocyte'::text, 'mesenchymal stem cell'::text, 'mesendoderm'::text, 'mesodermal cell'::text, 'myotube'::text, 'neural cell'::text, 'neural progenitor cell'::text, 'neuron'::text, 'neuronal stem cell'::text, 'smooth muscle cell'::text, 'trophoblast cell'::text])) THEN 'In vitro differentiated cells'::text
                        ELSE NULL::text
                    END
                    WHEN 'primary tissue'::text THEN
                    CASE
                        WHEN (metadata.term = ANY (ARRAY['Peyer''s patch'::text, 'adipose tissue'::text, 'adrenal gland'::text, 'ascending aorta'::text, 'body of pancreas'::text, 'bone marrow'::text, 'brain'::text, 'breast epithelium'::text, 'brown adipose tissue'::text, 'cerebellum'::text, 'cortex'::text, 'cortical plate'::text, 'embryo'::text, 'embryonic facial prominence'::text, 'esophagus muscularis mucosa'::text, 'esophagus squamous epithelium'::text, 'fast muscle tissue'::text, 'forebrain'::text, 'frontal cortex'::text, 'gastrocnemius medialis'::text, 'gastroesophageal sphincter'::text, 'gill filament'::text, 'gluteus medius'::text, 'gonad'::text, 'heart'::text, 'heart left ventricle'::text, 'hindbrain'::text, 'hindlimb muscle'::text, 'hypothalamus'::text, 'ileum'::text, 'immature gonad'::text, 'intestine'::text, 'kidney'::text, 'large intestine'::text, 'left lung lobe'::text, 'limb'::text, 'liver'::text, 'lobe of liver'::text, 'longissimus dorsi muscle'::text, 'lung'::text, 'mesonephros'::text, 'midbrain'::text, 'muscle of leg'::text, 'muscle of trunk'::text, 'neural tube'::text, 'olfactory bulb'::text, 'placenta'::text, 'prostate gland'::text, 'psoas muscle'::text, 'right atrium auricular region'::text, 'right lobe of liver'::text, 'sigmoid colon'::text, 'skeletal muscle tissue'::text, 'skin of back'::text, 'skin of body'::text, 'small intestine'::text, 'spleen'::text, 'stomach'::text, 'subcutaneous adipose tissue'::text, 'testis'::text, 'thoracic aorta'::text, 'thymus'::text, 'thyroid gland'::text, 'tibial artery'::text, 'tibial nerve'::text, 'trachea'::text, 'transverse colon'::text, 'upper lobe of left lung'::text, 'uterus'::text, 'vagina'::text])) THEN 'Primary tissue'::text
                        ELSE NULL::text
                    END
                    ELSE NULL::text
                END AS sample_type
           FROM public.curated_experiment_metadata metadata
        )
 SELECT classified.epigenome_id,
        CASE
            WHEN (count(DISTINCT classified.sample_type) = 1) THEN min(classified.sample_type)
            ELSE NULL::text
        END AS sample_type
   FROM classified
  GROUP BY classified.epigenome_id;


ALTER TABLE public.biosample_sample_type OWNER TO "ensreg-usr";

--
-- Name: biosample_term_group; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.biosample_term_group AS
 SELECT DISTINCT curated_experiment_metadata.epigenome_id,
        CASE
            WHEN ((curated_experiment_metadata.term ~~* '%terus%'::text) OR (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* ANY (ARRAY['%prostate%'::text, '%vagina%'::text]))) THEN 'reproductive'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%connective tissue%'::text) THEN 'connective tissue'::text
            WHEN ((array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%blood%'::text) OR (array_to_string(curated_experiment_metadata.cell_slims, ','::text) ~~* '%B cell%'::text) OR ((array_to_string(curated_experiment_metadata.cell_slims, ','::text) ~~* '%hematopoietic%'::text) AND (curated_experiment_metadata.term !~~* '%bone marrow%'::text))) THEN 'blood'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%bone marrow%'::text) THEN 'bone marrow'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%tibial nerve%'::text) THEN 'limb'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%blood vessel%'::text) THEN 'blood vessel'::text
            WHEN ((curated_experiment_metadata.term ~~* '%skin%'::text) OR (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%skin%'::text)) THEN 'skin'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%embryo%'::text) THEN 'embryonic'::text
            WHEN ((array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%liver%'::text) OR (curated_experiment_metadata.term ~~* '%liver%'::text)) THEN 'liver'::text
            WHEN ((array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%kidney%'::text) OR (curated_experiment_metadata.term ~~* ANY (ARRAY['%kidney%'::text, '%mesonephros%'::text]))) THEN 'kidney'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%epithel%'::text) THEN 'epithelium'::text
            WHEN ((curated_experiment_metadata.term ~~* '%testis%'::text) OR (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%testis%'::text)) THEN 'gonad'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%endocrine%'::text) THEN 'endocrine gland'::text
            WHEN ((array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* ANY (ARRAY['%spleen%'::text, '%thymus%'::text])) OR (curated_experiment_metadata.term ~~* ANY (ARRAY['%spleen%'::text, '%hymus%'::text]))) THEN 'immune organ'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%stomach%'::text) THEN 'stomach'::text
            WHEN ((curated_experiment_metadata.term ~~* '%muscle%'::text) OR (curated_experiment_metadata.term ~~* '%gluteus medius%'::text) OR (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* ANY (ARRAY['%musculature%'::text, '%gluteus%'::text, '%skeletal%'::text, '%longissimus%'::text]))) THEN 'muscle'::text
            WHEN ((array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%intestine%'::text) OR (curated_experiment_metadata.term ~~* ANY (ARRAY['%ileum%'::text, '%intestine%'::text]))) THEN 'intestine'::text
            WHEN (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%pancreas%'::text) THEN 'pancreas'::text
            WHEN ((array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%lung%'::text) OR (curated_experiment_metadata.term ~~* '%lung%'::text)) THEN 'lung'::text
            WHEN (curated_experiment_metadata.term ~~* '%tibial nerve%'::text) THEN 'limb'::text
            WHEN ((curated_experiment_metadata.term ~~* '%heart%'::text) OR (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%heart%'::text)) THEN 'heart'::text
            WHEN (curated_experiment_metadata.term ~~* '%neuron%'::text) THEN 'neural cell'::text
            WHEN ((curated_experiment_metadata.term ~~* '%brain%'::text) OR (array_to_string(curated_experiment_metadata.organ_slims, ','::text) ~~* '%brain%'::text) OR (curated_experiment_metadata.term ~~* ANY (ARRAY['%cortex%'::text, '%cerebellum%'::text, '%hypothalamus%'::text, '%neural progenitor%'::text]))) THEN 'brain'::text
            WHEN (curated_experiment_metadata.term ~~* '%adipose%'::text) THEN 'adipose'::text
            WHEN (curated_experiment_metadata.term = 'immature gonad'::text) THEN 'gonad'::text
            ELSE curated_experiment_metadata.term
        END AS term_group
   FROM public.curated_experiment_metadata;


ALTER TABLE public.biosample_term_group OWNER TO "ensreg-usr";

--
-- Name: base_epigenomes; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.base_epigenomes AS
 WITH slims_before_agg AS (
         SELECT curated_experiment_metadata.epigenome_id,
                CASE
                    WHEN (curated_experiment_metadata.organ_slims = ARRAY[]::text[]) THEN ARRAY['EMPTY'::text]
                    WHEN (curated_experiment_metadata.organ_slims IS NULL) THEN ARRAY['UNANNOTATED'::text]
                    ELSE curated_experiment_metadata.organ_slims
                END AS organs_mod,
                CASE
                    WHEN (curated_experiment_metadata.system_slims = ARRAY[]::text[]) THEN ARRAY['EMPTY'::text]
                    WHEN (curated_experiment_metadata.system_slims IS NULL) THEN ARRAY['UNANNOTATED'::text]
                    ELSE curated_experiment_metadata.system_slims
                END AS systems_mod
           FROM public.curated_experiment_metadata
        ), metadata_epig_with_ids AS (
         SELECT DISTINCT curated_experiment_metadata.species_name,
            curated_experiment_metadata.assembly_name,
            curated_experiment_metadata.epigenome_name,
            curated_experiment_metadata.epigenome_id,
            curated_experiment_metadata.epigenome_description,
            array_agg(DISTINCT curated_experiment_metadata.material) AS material,
            curated_experiment_metadata.term,
            curated_experiment_metadata.term_ontology,
            public.unnest_2d_1d(array_agg(DISTINCT slims_before_agg.organs_mod)) AS organs,
            public.unnest_2d_1d(array_agg(DISTINCT slims_before_agg.systems_mod)) AS systems,
            array_agg(DISTINCT curated_experiment_metadata.sex) AS sex,
            array_agg(DISTINCT curated_experiment_metadata.life_stage) AS life_stage,
            array_agg(DISTINCT curated_experiment_metadata.age ORDER BY curated_experiment_metadata.age) AS age,
            array_agg(DISTINCT curated_experiment_metadata.age_unit) AS age_unit
           FROM (public.curated_experiment_metadata
             JOIN slims_before_agg ON ((curated_experiment_metadata.epigenome_id = slims_before_agg.epigenome_id)))
          GROUP BY curated_experiment_metadata.species_name, curated_experiment_metadata.assembly_name, curated_experiment_metadata.epigenome_name, curated_experiment_metadata.epigenome_id, curated_experiment_metadata.epigenome_description, curated_experiment_metadata.term, curated_experiment_metadata.term_ontology
        ), slims_after_agg AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN (metadata_epig_with_ids_1.organs = ARRAY['EMPTY'::text]) THEN ARRAY[]::text[]
                    WHEN (metadata_epig_with_ids_1.organs = ARRAY['UNANNOTATED'::text]) THEN NULL::text[]
                    ELSE metadata_epig_with_ids_1.organs
                END AS organs,
                CASE
                    WHEN (metadata_epig_with_ids_1.systems = ARRAY['EMPTY'::text]) THEN ARRAY[]::text[]
                    WHEN (metadata_epig_with_ids_1.systems = ARRAY['UNANNOTATED'::text]) THEN NULL::text[]
                    ELSE metadata_epig_with_ids_1.systems
                END AS systems,
                CASE
                    WHEN ('unknown'::text = ANY (metadata_epig_with_ids_1.age)) THEN NULL::numeric[]
                    ELSE (metadata_epig_with_ids_1.age)::numeric[]
                END AS age,
            metadata_epig_with_ids_1.age_unit
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        ), handle_age_after_agg AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN ('unknown'::text = ANY (metadata_epig_with_ids_1.age)) THEN NULL::numeric[]
                    ELSE (metadata_epig_with_ids_1.age)::numeric[]
                END AS age
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        ), sort_agg_age AS (
         SELECT handle_age_after_agg.epigenome_id,
            ARRAY( SELECT unnest(handle_age_after_agg.age) AS unnest
                  ORDER BY (unnest(handle_age_after_agg.age))) AS age_sorted
           FROM handle_age_after_agg
        ), handle_sorted_age AS (
         SELECT sort_agg_age.epigenome_id,
                CASE
                    WHEN (ARRAY[]::numeric[] = sort_agg_age.age_sorted) THEN NULL::text
                    WHEN (array_length(sort_agg_age.age_sorted, 1) = 1) THEN ((sort_agg_age.age_sorted[1])::real)::text
                    ELSE ((sort_agg_age.age_sorted)::real[])::text
                END AS age
           FROM sort_agg_age
        ), handle_age_unit_after_agg AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN ('unknown'::text = ANY (metadata_epig_with_ids_1.age)) THEN NULL::text
                    WHEN ((('embryo'::text = ANY (metadata_epig_with_ids_1.life_stage)) OR ('embryonic'::text = ANY (metadata_epig_with_ids_1.life_stage))) AND ('day'::text = ANY (metadata_epig_with_ids_1.age_unit))) THEN 'days post fertilisation'::text
                    ELSE array_to_string(metadata_epig_with_ids_1.age_unit, ', '::text)
                END AS age_unit
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        ), handle_age_unit_singular_plural AS (
         SELECT handle_age_unit_after_agg.epigenome_id,
                CASE
                    WHEN ((handle_age_unit_after_agg.age_unit <> 'days post fertilisation'::text) AND (handle_age_unit_after_agg.age_unit <> 'thermal time'::text) AND (sort_agg_age.age_sorted[1] <> (1)::numeric)) THEN concat(handle_age_unit_after_agg.age_unit, 's')
                    ELSE handle_age_unit_after_agg.age_unit
                END AS age_unit
           FROM (handle_age_unit_after_agg
             JOIN sort_agg_age ON ((handle_age_unit_after_agg.epigenome_id = sort_agg_age.epigenome_id)))
        ), age_range AS (
         SELECT sort_agg_age.epigenome_id,
                CASE
                    WHEN (ARRAY[]::numeric[] = sort_agg_age.age_sorted) THEN NULL::text
                    WHEN (array_length(sort_agg_age.age_sorted, 1) = 1) THEN ((sort_agg_age.age_sorted[1])::real)::text
                    ELSE concat(((sort_agg_age.age_sorted[1])::real)::text, '-', ((sort_agg_age.age_sorted[array_upper(sort_agg_age.age_sorted, 1)])::real)::text)
                END AS age_range
           FROM sort_agg_age
        ), shorten_age_unit AS (
         SELECT handle_age_unit_after_agg.epigenome_id,
                CASE
                    WHEN (handle_age_unit_after_agg.age_unit = 'days post fertilisation'::text) THEN 'dpf'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'month'::text) THEN 'mo'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'year'::text) THEN 'y'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'week'::text) THEN 'w'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'day'::text) THEN 'd'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'thermal time'::text) THEN 'tt'::text
                    ELSE handle_age_unit_after_agg.age_unit
                END AS short_age_unit
           FROM handle_age_unit_after_agg
        ), shorten_sex AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['unknown'::text]) THEN NULL::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['mixed'::text]) THEN NULL::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['male'::text, 'female'::text]) THEN NULL::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] = ARRAY['male'::text]) THEN 'm'::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] = ARRAY['female'::text]) THEN 'f'::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] = ARRAY['phenotypic'::text]) THEN NULL::text
                    ELSE 'Err: not contemplated case'::text
                END AS sex_for_label
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        ), lifestage_in_label AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN ((((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['phenotypic'::text]) OR ((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['unknown'::text])) AND (metadata_epig_with_ids_1.term = 'embryo'::text)) THEN metadata_epig_with_ids_1.life_stage
                    ELSE NULL::text[]
                END AS life_stage_info_for_label
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        )
 SELECT DISTINCT metadata_epig_with_ids.species_name,
    metadata_epig_with_ids.assembly_name,
    metadata_epig_with_ids.epigenome_id AS id,
    lower(array_to_string(metadata_epig_with_ids.material, ', '::text)) AS material,
    metadata_epig_with_ids.epigenome_name,
    metadata_epig_with_ids.term,
        CASE
            WHEN (metadata_epig_with_ids.term <> 'embryo'::text) THEN metadata_epig_with_ids.term
            ELSE NULL::text
        END AS term_for_label,
    metadata_epig_with_ids.term_ontology,
    array_to_string(metadata_epig_with_ids.sex, ', '::text) AS sex,
    shorten_sex.sex_for_label,
    array_to_string(metadata_epig_with_ids.life_stage, ', '::text) AS life_stage,
        CASE
            WHEN ((((metadata_epig_with_ids.sex)::text[] @> ARRAY['phenotypic'::text]) OR ((metadata_epig_with_ids.sex)::text[] @> ARRAY['unknown'::text])) AND (metadata_epig_with_ids.term = 'embryo'::text)) THEN array_to_string(metadata_epig_with_ids.life_stage, ', '::text)
            ELSE NULL::text
        END AS life_stage_for_label,
        CASE
            WHEN (handle_sorted_age.age IS NULL) THEN NULL::text
            ELSE concat(handle_sorted_age.age, ' ', handle_age_unit_singular_plural.age_unit)
        END AS extended_age,
        CASE
            WHEN (handle_sorted_age.age IS NULL) THEN NULL::text
            ELSE concat(age_range.age_range, ' ', shorten_age_unit.short_age_unit)
        END AS age,
        CASE
            WHEN (((metadata_epig_with_ids.assembly_name)::text = 'GRCm39'::text) AND (array_to_string(metadata_epig_with_ids.life_stage, ', '::text) = 'embryonic'::text) AND (age_range.age_range IS NOT NULL)) THEN concat('E', age_range.age_range)
            WHEN (handle_sorted_age.age IS NULL) THEN NULL::text
            ELSE concat(age_range.age_range, ' ', shorten_age_unit.short_age_unit)
        END AS age_for_label,
    slims_after_agg.organs,
    slims_after_agg.systems,
    biosample_term_group.term_group AS tissue_group,
    biosample_biological_group.biological_group,
    biosample_sample_type.sample_type
   FROM (((((((((metadata_epig_with_ids
     JOIN handle_sorted_age ON ((metadata_epig_with_ids.epigenome_id = handle_sorted_age.epigenome_id)))
     JOIN age_range ON ((metadata_epig_with_ids.epigenome_id = age_range.epigenome_id)))
     JOIN handle_age_unit_singular_plural ON ((metadata_epig_with_ids.epigenome_id = handle_age_unit_singular_plural.epigenome_id)))
     JOIN shorten_age_unit ON ((metadata_epig_with_ids.epigenome_id = shorten_age_unit.epigenome_id)))
     JOIN slims_after_agg ON ((metadata_epig_with_ids.epigenome_id = slims_after_agg.epigenome_id)))
     JOIN shorten_sex ON ((metadata_epig_with_ids.epigenome_id = shorten_sex.epigenome_id)))
     JOIN public.biosample_term_group ON ((metadata_epig_with_ids.epigenome_id = biosample_term_group.epigenome_id)))
     LEFT JOIN public.biosample_biological_group ON ((metadata_epig_with_ids.epigenome_id = biosample_biological_group.epigenome_id)))
     LEFT JOIN public.biosample_sample_type ON ((metadata_epig_with_ids.epigenome_id = biosample_sample_type.epigenome_id)))
  WHERE (((metadata_epig_with_ids.assembly_name)::text <> 'GRCg6a'::text) AND (metadata_epig_with_ids.term <> 'iPS-18c'::text));


ALTER TABLE public.base_epigenomes OWNER TO "ensreg-usr";

--
-- Name: base_epigenomes_flat_payload; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.base_epigenomes_flat_payload AS
 WITH species AS (
         SELECT DISTINCT base_epigenomes.species_name
           FROM public.base_epigenomes
        )
 SELECT json_agg(json_build_object('species_name', species.species_name, 'base_epigenomes', ( SELECT json_agg(json_build_object('species_name', base_epigenomes.species_name, 'assembly_name', base_epigenomes.assembly_name, 'id', base_epigenomes.id, 'material', base_epigenomes.material, 'term', base_epigenomes.term, 'sex', base_epigenomes.sex, 'life_stage', base_epigenomes.life_stage, 'age', base_epigenomes.age_for_label, 'organs', base_epigenomes.organs, 'systems', base_epigenomes.systems, 'tissue_group', base_epigenomes.tissue_group, 'biological_group', base_epigenomes.biological_group, 'sample_type', base_epigenomes.sample_type)) AS json_agg
           FROM public.base_epigenomes
          WHERE (base_epigenomes.species_name = species.species_name)
          GROUP BY base_epigenomes.species_name))) AS json_agg
   FROM species;


ALTER TABLE public.base_epigenomes_flat_payload OWNER TO "ensreg-usr";

--
-- Name: base_epigenomes_payload; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.base_epigenomes_payload AS
 WITH base_epigenome_objects AS (
         SELECT base_epigenomes.species_name,
            base_epigenomes.id,
            json_build_object('id', base_epigenomes.id, 'material', base_epigenomes.material, 'term', json_build_object('value', base_epigenomes.term, 'ontology', json_build_object('curie', replace(base_epigenomes.term_ontology, '_'::text, ':'::text), 'url', concat('https://purl.obolibrary.org/obo/', base_epigenomes.term_ontology))), 'sex', base_epigenomes.sex, 'life_stage', json_build_object('value', base_epigenomes.life_stage, 'rank', NULL::integer), 'age',
                CASE
                    WHEN (base_epigenomes.age_for_label IS NULL) THEN NULL::json
                    ELSE json_build_object('value', base_epigenomes.age_for_label, 'description', base_epigenomes.extended_age, 'rank', NULL::integer)
                END, 'organs',
                CASE
                    WHEN (base_epigenomes.organs IS NULL) THEN NULL::json
                    ELSE COALESCE(( SELECT json_agg(json_build_object('value', organ.value, 'ontology', json_build_object('curie', NULL::text, 'url', NULL::text)) ORDER BY organ.value) AS json_agg
                       FROM unnest(base_epigenomes.organs) organ(value)), '[]'::json)
                END, 'systems',
                CASE
                    WHEN (base_epigenomes.systems IS NULL) THEN NULL::json
                    ELSE COALESCE(( SELECT json_agg(json_build_object('value', system.value, 'ontology', json_build_object('curie', NULL::text, 'url', NULL::text)) ORDER BY system.value) AS json_agg
                       FROM unnest(base_epigenomes.systems) system(value)), '[]'::json)
                END, 'tissue_group', json_build_object('value', base_epigenomes.tissue_group, 'ontology', json_build_object('curie', NULL::text, 'url', NULL::text)), 'biological_group', json_build_object('value', base_epigenomes.biological_group, 'ontology', json_build_object('curie', NULL::text, 'url', NULL::text)), 'sample_type', json_build_object('value', base_epigenomes.sample_type, 'ontology', json_build_object('curie', NULL::text, 'url', NULL::text))) AS base_epigenome
           FROM public.base_epigenomes
        ), species_base_epigenomes AS (
         SELECT base_epigenome_objects.species_name,
            json_agg(base_epigenome_objects.base_epigenome ORDER BY base_epigenome_objects.id) AS base_epigenomes
           FROM base_epigenome_objects
          GROUP BY base_epigenome_objects.species_name
        )
 SELECT json_agg(json_build_object('species_name', species_base_epigenomes.species_name, 'base_epigenomes', species_base_epigenomes.base_epigenomes) ORDER BY species_base_epigenomes.species_name) AS json_agg
   FROM species_base_epigenomes;


ALTER TABLE public.base_epigenomes_payload OWNER TO "ensreg-usr";

--
-- Name: curated_experiment_analysis_files; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.curated_experiment_analysis_files AS
 WITH signal_files AS (
         SELECT analysis_file.analysis_file_id AS signal_analysis_file_id,
            analysis_file.experiment_id AS signal_experiment_id,
            assembly_1.assembly_id AS signal_assembly_id,
            s3_object.key AS signal_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'signal'::public.analysis_type)
        ), atac_seq_peak_files AS (
         SELECT analysis_file.analysis_file_id AS atac_seq_peak_analysis_file_id,
            analysis_file.experiment_id AS atac_seq_peak_experiment_id,
            assembly_1.assembly_id AS atac_seq_peak_assembly_id,
            s3_object.key AS atac_seq_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'atac_seq_peaks'::public.analysis_type)
        ), dnase_seq_peak_files AS (
         SELECT analysis_file.analysis_file_id AS dnase_seq_peak_analysis_file_id,
            analysis_file.experiment_id AS dnase_seq_peak_experiment_id,
            assembly_1.assembly_id AS dnase_seq_peak_assembly_id,
            s3_object.key AS dnase_seq_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'dnase_seq_peaks'::public.analysis_type)
        ), chip_seq_narrow_peak_files AS (
         SELECT analysis_file.analysis_file_id AS chip_seq_narrow_peak_analysis_file_id,
            analysis_file.experiment_id AS chip_seq_narrow_peak_experiment_id,
            assembly_1.assembly_id AS chip_seq_narrow_peak_assembly_id,
            s3_object.key AS chip_seq_narrow_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'chip_seq_narrow_peaks'::public.analysis_type)
        ), chip_seq_broad_peak_files AS (
         SELECT analysis_file.analysis_file_id AS chip_seq_broad_peak_analysis_file_id,
            analysis_file.experiment_id AS chip_seq_broad_peak_experiment_id,
            assembly_1.assembly_id AS chip_seq_broad_peak_assembly_id,
            s3_object.key AS chip_seq_broad_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'chip_seq_broad_peaks'::public.analysis_type)
        ), chip_seq_gapped_peak_files AS (
         SELECT analysis_file.analysis_file_id AS chip_seq_gapped_peak_analysis_file_id,
            analysis_file.experiment_id AS chip_seq_gapped_peak_experiment_id,
            assembly_1.assembly_id AS chip_seq_gapped_peak_assembly_id,
            s3_object.key AS chip_seq_gapped_peak_key
           FROM (((public.analysis_file
             JOIN public.assembly assembly_1 ON ((analysis_file.assembly_id = assembly_1.assembly_id)))
             JOIN public.file ON ((analysis_file.file_id = file.file_id)))
             JOIN public.s3_object ON ((file.file_id = s3_object.file_id)))
          WHERE (analysis_file.analysis_type = 'chip_seq_gapped_peaks'::public.analysis_type)
        )
 SELECT DISTINCT curated_experiment_metadata.experiment_id,
    curated_experiment_metadata.assembly_id,
    COALESCE(atac_seq_peak_files.atac_seq_peak_key, dnase_seq_peak_files.dnase_seq_peak_key) AS open_chromatin_peak,
    chip_seq_narrow_peak_files.chip_seq_narrow_peak_key,
    chip_seq_broad_peak_files.chip_seq_broad_peak_key,
    chip_seq_gapped_peak_files.chip_seq_gapped_peak_key,
    signal_files.signal_key
   FROM ((((((public.curated_experiment_metadata
     LEFT JOIN signal_files ON (((curated_experiment_metadata.experiment_id = signal_files.signal_experiment_id) AND (signal_files.signal_assembly_id = curated_experiment_metadata.assembly_id))))
     LEFT JOIN atac_seq_peak_files ON (((curated_experiment_metadata.experiment_id = atac_seq_peak_files.atac_seq_peak_experiment_id) AND (atac_seq_peak_files.atac_seq_peak_assembly_id = curated_experiment_metadata.assembly_id))))
     LEFT JOIN dnase_seq_peak_files ON (((curated_experiment_metadata.experiment_id = dnase_seq_peak_files.dnase_seq_peak_experiment_id) AND (dnase_seq_peak_files.dnase_seq_peak_assembly_id = curated_experiment_metadata.assembly_id))))
     LEFT JOIN chip_seq_narrow_peak_files ON (((curated_experiment_metadata.experiment_id = chip_seq_narrow_peak_files.chip_seq_narrow_peak_experiment_id) AND (chip_seq_narrow_peak_files.chip_seq_narrow_peak_assembly_id = curated_experiment_metadata.assembly_id))))
     LEFT JOIN chip_seq_broad_peak_files ON (((curated_experiment_metadata.experiment_id = chip_seq_broad_peak_files.chip_seq_broad_peak_experiment_id) AND (chip_seq_broad_peak_files.chip_seq_broad_peak_assembly_id = curated_experiment_metadata.assembly_id))))
     LEFT JOIN chip_seq_gapped_peak_files ON (((curated_experiment_metadata.experiment_id = chip_seq_gapped_peak_files.chip_seq_gapped_peak_experiment_id) AND (chip_seq_gapped_peak_files.chip_seq_gapped_peak_assembly_id = curated_experiment_metadata.assembly_id))));


ALTER TABLE public.curated_experiment_analysis_files OWNER TO "ensreg-usr";

--
-- Name: base_epigenomes_replicates_and_files; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.base_epigenomes_replicates_and_files AS
 WITH no_replicates AS (
         SELECT base_epigenome_replicates_1.assembly_name,
            base_epigenome_replicates_1.base_epigenome_id,
            base_epigenome_replicates_1.experiment_type,
            base_epigenome_replicates_1.experiment_target,
            count(*) AS number_of_replicates
           FROM public.base_epigenome_replicates base_epigenome_replicates_1
          GROUP BY base_epigenome_replicates_1.assembly_name, base_epigenome_replicates_1.base_epigenome_id, base_epigenome_replicates_1.experiment_type, base_epigenome_replicates_1.experiment_target
        )
 SELECT DISTINCT base_epigenome_replicates.species_name,
    base_epigenome_replicates.assembly_name,
    base_epigenome_replicates.base_epigenome_id,
    base_epigenome_replicates.material,
    base_epigenome_replicates.term,
    base_epigenome_replicates.term_for_label,
    base_epigenome_replicates.term_ontology,
    base_epigenome_replicates.sex,
    base_epigenome_replicates.sex_for_label,
    base_epigenome_replicates.life_stage,
    base_epigenome_replicates.life_stage_for_label,
    base_epigenome_replicates.age_value,
    base_epigenome_replicates.age_unit,
    base_epigenome_replicates.modified_age_unit,
    base_epigenome_replicates.extended_age,
    base_epigenome_replicates.short_age,
    base_epigenome_replicates.age_for_label,
    base_epigenome_replicates.experiment_type,
    base_epigenome_replicates.experiment_target,
    base_epigenome_replicates.biosample_accession,
    base_epigenome_replicates.data_source,
    biosample_term_group.term_group,
    no_replicates.number_of_replicates,
    curated_experiment_analysis_files.experiment_id,
    curated_experiment_analysis_files.assembly_id,
    curated_experiment_analysis_files.open_chromatin_peak,
    curated_experiment_analysis_files.chip_seq_gapped_peak_key,
    curated_experiment_analysis_files.chip_seq_narrow_peak_key,
    curated_experiment_analysis_files.signal_key,
    biosample_biological_group.biological_group,
    biosample_sample_type.sample_type
   FROM ((((((public.curated_experiment_metadata
     JOIN public.curated_experiment_analysis_files ON (((curated_experiment_metadata.experiment_id = curated_experiment_analysis_files.experiment_id) AND (curated_experiment_metadata.assembly_id = curated_experiment_analysis_files.assembly_id))))
     JOIN public.base_epigenome_replicates ON (((curated_experiment_metadata.experiment_type = base_epigenome_replicates.experiment_type) AND (curated_experiment_metadata.experiment_target = base_epigenome_replicates.experiment_target) AND (curated_experiment_metadata.epigenome_id = base_epigenome_replicates.base_epigenome_id) AND ((curated_experiment_metadata.assembly_name)::text = (base_epigenome_replicates.assembly_name)::text) AND (curated_experiment_metadata.species_name = base_epigenome_replicates.species_name))))
     JOIN no_replicates ON (((curated_experiment_metadata.experiment_type = no_replicates.experiment_type) AND (curated_experiment_metadata.experiment_target = no_replicates.experiment_target) AND (curated_experiment_metadata.epigenome_id = no_replicates.base_epigenome_id) AND ((curated_experiment_metadata.assembly_name)::text = (no_replicates.assembly_name)::text))))
     JOIN public.biosample_term_group ON (((base_epigenome_replicates.base_epigenome_id = biosample_term_group.epigenome_id) AND (curated_experiment_metadata.epigenome_id = biosample_term_group.epigenome_id) AND (no_replicates.base_epigenome_id = biosample_term_group.epigenome_id))))
     LEFT JOIN public.biosample_biological_group ON ((base_epigenome_replicates.base_epigenome_id = biosample_biological_group.epigenome_id)))
     LEFT JOIN public.biosample_sample_type ON ((base_epigenome_replicates.base_epigenome_id = biosample_sample_type.epigenome_id)));


ALTER TABLE public.base_epigenomes_replicates_and_files OWNER TO "ensreg-usr";

--
-- Name: bucket; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.bucket (
    name text NOT NULL,
    endpoint text NOT NULL,
    bucket_id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.bucket OWNER TO "ensreg-usr";

--
-- Name: curated_open_chromatin_assay_metadata; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.curated_open_chromatin_assay_metadata AS
 SELECT DISTINCT experiment_metadata.species_name,
    experiment_metadata.epigenome_name,
    experiment_metadata.name,
    COALESCE(experiment_metadata.accession, experiment_metadata.biosample_accession) AS biosample_accession,
    initcap(replace((experiment_metadata.biomaterial_type)::text, '_'::text, ' '::text)) AS material,
        CASE
            WHEN (experiment_metadata.biosample_term = ANY (ARRAY['Thymus'::text, 'Uterus'::text])) THEN lower(experiment_metadata.biosample_term)
            ELSE experiment_metadata.biosample_term
        END AS term,
    concat(experiment_metadata.ontology_type, '_', experiment_metadata.curie) AS term_ontology,
    experiment_metadata.organ_slims,
    experiment_metadata.system_slims,
        CASE
            WHEN (experiment_metadata.experiment_type = 'atac_seq'::public.experiment_type) THEN 'ATAC-seq'::text
            WHEN (experiment_metadata.experiment_type = 'dnase_seq'::public.experiment_type) THEN 'DNase-seq'::text
            WHEN (experiment_metadata.experiment_type = 'chip_seq'::public.experiment_type) THEN 'ChIP-seq'::text
            ELSE NULL::text
        END AS experiment_type,
        CASE
            WHEN (experiment_metadata.experiment_target_type = 'atac_seq'::text) THEN 'open chromatin'::text
            WHEN (experiment_metadata.experiment_target_type = 'dnase_seq'::text) THEN 'open chromatin'::text
            WHEN (experiment_metadata.experiment_target_type = 'tf'::text) THEN 'transcription factor'::text
            WHEN (experiment_metadata.experiment_target_type = 'histone'::text) THEN 'histone'::text
            ELSE NULL::text
        END AS experiment_target_type,
        CASE
            WHEN ((experiment_metadata.experiment_target = 'atac_seq'::text) OR (experiment_metadata.experiment_target = 'dnase_seq'::text)) THEN 'open chromatin'::text
            ELSE experiment_metadata.experiment_target
        END AS experiment_target,
    experiment_metadata.sex,
    COALESCE(experiment_metadata.life_stage_term, 'unknown'::text) AS life_stage,
        CASE
            WHEN (experiment_metadata.thermal_time IS NOT NULL) THEN (round(experiment_metadata.thermal_time, 2))::text
            WHEN (lower(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)) = upper(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age))) THEN (lower(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)))::text
            WHEN (lower(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)) <> upper(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age))) THEN concat(lower(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)), '-', upper(COALESCE(experiment_metadata.age_at_collection, experiment_metadata.age)))
            ELSE 'unknown'::text
        END AS age,
        CASE
            WHEN (experiment_metadata.thermal_time IS NOT NULL) THEN 'thermal time'::text
            ELSE (COALESCE(experiment_metadata.age_at_collection_unit, experiment_metadata.age_unit))::text
        END AS age_unit,
    COALESCE(experiment_metadata.replicate_set_accession, experiment_metadata.replicate_accession) AS data_source,
    experiment_metadata.assembly_name,
    experiment_metadata.experiment_id,
    experiment_metadata.epigenome_id,
    experiment_metadata.epigenome_description,
    experiment_metadata.cell_slims,
    experiment_metadata.species_id,
    experiment_metadata.assembly_id
   FROM (public.experiment_metadata
     JOIN public.analysis_file ON (((experiment_metadata.experiment_id = analysis_file.experiment_id) AND (analysis_file.assembly_id = experiment_metadata.assembly_id))))
  WHERE ((analysis_file.handover = true) AND (experiment_metadata.replicate_set_type = 'signal'::text) AND (analysis_file.analysis_type = ANY (ARRAY['dnase_seq_peaks'::public.analysis_type, 'atac_seq_peaks'::public.analysis_type])) AND (experiment_metadata.biomaterial_type IS NOT NULL) AND (experiment_metadata.experiment_id <> ALL (ARRAY['d19b02d2-d571-4ba8-9f24-b875fa3c69f5'::uuid, 'd67055dd-893e-48dc-bf80-3c7540e1fb7a'::uuid, '32f3f1f1-1a50-4a87-8cc7-582a52213689'::uuid])));


ALTER TABLE public.curated_open_chromatin_assay_metadata OWNER TO "ensreg-usr";

--
-- Name: experiment_target_info; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.experiment_target_info AS
 SELECT experiment_signal_target_info.name,
    experiment_signal_target_info.experiment_type,
    experiment_signal_target_info.epigenome_id,
    experiment_signal_target_info.experiment_id,
    experiment_signal_target_info.data_source_id,
    experiment_signal_target_info.replicate_set_id,
    experiment_signal_target_info.replicate_set_type,
    experiment_signal_target_info.experiment_target_type,
    experiment_signal_target_info.experiment_target
   FROM public.experiment_signal_target_info
UNION ALL
 SELECT experiment_control_target_info.name,
    experiment_control_target_info.experiment_type,
    experiment_control_target_info.epigenome_id,
    experiment_control_target_info.experiment_id,
    experiment_control_target_info.data_source_id,
    experiment_control_target_info.replicate_set_id,
    experiment_control_target_info.replicate_set_type,
    experiment_control_target_info.experiment_target_type,
    experiment_control_target_info.experiment_target
   FROM public.experiment_control_target_info;


ALTER TABLE public.experiment_target_info OWNER TO "ensreg-usr";

--
-- Name: inclusion_list; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.inclusion_list (
    inclusion_list_id uuid DEFAULT gen_random_uuid() NOT NULL,
    chemistry character varying NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.inclusion_list OWNER TO "ensreg-usr";

--
-- Name: read_file_set; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.read_file_set (
    read_file_set_id uuid DEFAULT gen_random_uuid() NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.read_file_set OWNER TO "ensreg-usr";

--
-- Name: library_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.library_data_source AS
 SELECT read_file_set.read_file_set_id,
    read_file_set.data_source_id,
    data_source.accession AS library_accession
   FROM (public.read_file_set
     LEFT JOIN public.data_source ON ((read_file_set.data_source_id = data_source.data_source_id)));


ALTER TABLE public.library_data_source OWNER TO "ensreg-usr";

--
-- Name: mask_file; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.mask_file (
    mask_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    assembly_id uuid NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.mask_file OWNER TO "ensreg-usr";

--
-- Name: metadata_dimensions; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.metadata_dimensions AS
 WITH base_epigenomes AS MATERIALIZED (
         SELECT base_epigenomes.species_name,
            base_epigenomes.assembly_name,
            base_epigenomes.id,
            base_epigenomes.material,
            base_epigenomes.epigenome_name,
            base_epigenomes.term,
            base_epigenomes.term_for_label,
            base_epigenomes.term_ontology,
            base_epigenomes.sex,
            base_epigenomes.sex_for_label,
            base_epigenomes.life_stage,
            base_epigenomes.life_stage_for_label,
            base_epigenomes.extended_age,
            base_epigenomes.age,
            base_epigenomes.age_for_label,
            base_epigenomes.organs,
            base_epigenomes.systems,
            base_epigenomes.tissue_group,
            base_epigenomes.biological_group,
            base_epigenomes.sample_type
           FROM public.base_epigenomes
        ), species AS (
         SELECT DISTINCT base_epigenomes.species_name
           FROM base_epigenomes
        ), assemblies AS (
         SELECT base_epigenomes.species_name,
            array_agg(DISTINCT base_epigenomes.assembly_name) AS assemblies
           FROM base_epigenomes
          GROUP BY base_epigenomes.species_name
        ), base_epigenome_terms AS (
         SELECT DISTINCT base_epigenomes.species_name,
            base_epigenomes.term,
            base_epigenomes.term_ontology
           FROM base_epigenomes
        ), base_epigeome_age AS (
         SELECT DISTINCT base_epigenomes.species_name,
            base_epigenomes.age_for_label AS age,
            base_epigenomes.extended_age
           FROM base_epigenomes
          WHERE (base_epigenomes.age IS NOT NULL)
        ), base_epigenome_organ AS (
         SELECT DISTINCT base_epigenomes.species_name,
            unnest(base_epigenomes.organs) AS organ
           FROM base_epigenomes
        ), base_epigenome_system AS (
         SELECT DISTINCT base_epigenomes.species_name,
            unnest(base_epigenomes.systems) AS system
           FROM base_epigenomes
        ), base_epigenome_tissue_group AS (
         SELECT DISTINCT base_epigenomes.species_name,
            base_epigenomes.tissue_group
           FROM base_epigenomes
        ), base_epigenome_biological_group AS (
         SELECT DISTINCT base_epigenomes.species_name,
            base_epigenomes.biological_group
           FROM base_epigenomes
          WHERE (base_epigenomes.biological_group IS NOT NULL)
        ), base_epigenome_sample_type AS (
         SELECT DISTINCT base_epigenomes.species_name,
            base_epigenomes.sample_type
           FROM base_epigenomes
          WHERE (base_epigenomes.sample_type IS NOT NULL)
        ), filter_menu AS (
         SELECT DISTINCT base_epigenomes.species_name,
                CASE
                    WHEN ((base_epigenomes.organs IS NULL) AND (base_epigenomes.systems IS NULL)) THEN (json_build_array(json_build_array('term'), json_build_array('tissue_group'), json_build_array('biological_group'), json_build_array('sample_type'), json_build_array('sex'), json_build_array('life_stage'), json_build_array('material')))::jsonb
                    ELSE (json_build_array(json_build_array('term'), json_build_array('tissue_group'), json_build_array('biological_group'), json_build_array('sample_type'), json_build_array('organs'), json_build_array('systems'), json_build_array('sex'), json_build_array('life_stage'), json_build_array('material')))::jsonb
                END AS filter_layout
           FROM base_epigenomes
        ), table_layout AS (
         SELECT DISTINCT base_epigenomes.species_name,
            (json_build_array('tissue_group', 'term', 'life_stage', 'age', 'sex', 'material'))::jsonb AS layout
           FROM base_epigenomes
        ), optional AS (
         SELECT DISTINCT base_epigenomes.species_name,
                CASE
                    WHEN ((base_epigenomes.organs IS NULL) AND (base_epigenomes.systems IS NULL)) THEN (json_build_array('biological_group', 'sample_type'))::jsonb
                    ELSE (json_build_array('organs', 'systems', 'biological_group', 'sample_type'))::jsonb
                END AS dimensions
           FROM base_epigenomes
        ), collapsible AS (
         SELECT DISTINCT base_epigenomes.species_name,
            (json_build_array('sex', 'life_stage', 'age'))::jsonb AS dimensions
           FROM base_epigenomes
        ), filterable AS (
         SELECT DISTINCT base_epigenomes.species_name,
                CASE
                    WHEN ((base_epigenomes.organs IS NULL) AND (base_epigenomes.systems IS NULL)) THEN (json_build_array('material', 'tissue_group', 'biological_group', 'sample_type', 'sex', 'term', 'life_stage'))::jsonb
                    ELSE (json_build_array('material', 'tissue_group', 'biological_group', 'sample_type', 'sex', 'term', 'life_stage', 'organs', 'systems'))::jsonb
                END AS dimensions
           FROM base_epigenomes
        ), sortable AS (
         SELECT DISTINCT base_epigenomes.species_name,
                CASE
                    WHEN ((base_epigenomes.organs IS NULL) AND (base_epigenomes.systems IS NULL)) THEN (json_build_array('term', 'tissue_group', 'biological_group', 'sample_type', 'life_stage', 'sex', 'material'))::jsonb
                    ELSE (json_build_array('tissue_group', 'biological_group', 'sample_type', 'organs', 'life_stage', 'sex', 'material', 'term', 'systems'))::jsonb
                END AS dimensions
           FROM base_epigenomes
        ), zero_counts_visible AS (
         SELECT DISTINCT base_epigenomes.species_name,
                CASE
                    WHEN ((base_epigenomes.organs IS NULL) AND (base_epigenomes.systems IS NULL)) THEN (json_build_array('material'))::jsonb
                    ELSE (json_build_array('material', 'systems'))::jsonb
                END AS dimensions
           FROM base_epigenomes
        ), species_dimensions AS (
         SELECT json_build_object('species_name', species.species_name, 'assemblies', ( SELECT assemblies.assemblies
                   FROM assemblies
                  WHERE (assemblies.species_name = species.species_name)), 'ui_spec', json_build_object('filter_layout', ( SELECT filter_menu.filter_layout
                   FROM filter_menu
                  WHERE (filter_menu.species_name = species.species_name)), 'table_layout', ( SELECT table_layout.layout
                   FROM table_layout
                  WHERE (table_layout.species_name = species.species_name)), 'optional', ( SELECT optional.dimensions
                   FROM optional
                  WHERE (optional.species_name = species.species_name)), 'collapsible', ( SELECT collapsible.dimensions
                   FROM collapsible
                  WHERE (collapsible.species_name = species.species_name)), 'default_collapsed_by', json_build_array('age', 'sex'), 'filterable', ( SELECT filterable.dimensions
                   FROM filterable
                  WHERE (filterable.species_name = species.species_name)), 'sortable', ( SELECT sortable.dimensions
                   FROM sortable
                  WHERE (sortable.species_name = species.species_name)), 'zero_counts_visible', ( SELECT zero_counts_visible.dimensions
                   FROM zero_counts_visible
                  WHERE (zero_counts_visible.species_name = species.species_name))), 'dimensions', json_build_object('material', json_build_object('name', 'Biosample material', 'type', 'categorical', 'values', ( SELECT json_agg(DISTINCT b.material) AS json_agg
                   FROM base_epigenomes b
                  WHERE (b.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values',
                CASE
                    WHEN (species.species_name = ANY (ARRAY['Homo sapiens'::text, 'Mus musculus'::text])) THEN json_build_array('cell line')
                    ELSE json_build_array()
                END)), 'sex', json_build_object('name', 'Sex', 'type', 'categorical', 'values', ( SELECT json_agg(DISTINCT b.sex) AS json_agg
                   FROM base_epigenomes b
                  WHERE (b.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())), 'term', json_build_object('name', 'Biosample term', 'type', 'categorical_with_ontology', 'values', ( SELECT json_agg(json_build_object('value', t.term, 'ontology', json_build_object('curie', replace(t.term_ontology, '_'::text, ':'::text), 'url', concat('https://purl.obolibrary.org/obo/', t.term_ontology)))) AS json_agg
                   FROM base_epigenome_terms t
                  WHERE (t.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())), 'life_stage', json_build_object('name', 'Life stage', 'type', 'categorical', 'values', ( SELECT json_agg(DISTINCT b.life_stage) AS json_agg
                   FROM base_epigenomes b
                  WHERE (b.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())), 'age', json_build_object('name', 'Age', 'type', 'categorical_with_description', 'values', ( SELECT json_agg(json_build_object('value', a.age, 'description', a.extended_age)) AS json_agg
                   FROM base_epigeome_age a
                  WHERE (a.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())), 'organs', json_build_object('name', 'Organ', 'type', 'categorical_with_ontology', 'values', ( SELECT json_agg(json_build_object('value', o.organ, 'ontology', json_build_object('curie', NULL::unknown, 'url', NULL::unknown))) AS json_agg
                   FROM base_epigenome_organ o
                  WHERE (o.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())), 'systems', json_build_object('name', 'System', 'type', 'categorical_with_ontology', 'values', ( SELECT json_agg(json_build_object('value', s.system, 'ontology', json_build_object('curie', NULL::unknown, 'url', NULL::unknown))) AS json_agg
                   FROM base_epigenome_system s
                  WHERE (s.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())), 'tissue_group', json_build_object('name', 'Tissue group', 'type', 'categorical_with_ontology', 'values', ( SELECT json_agg(json_build_object('value', t.tissue_group, 'ontology', json_build_object('curie', NULL::unknown, 'url', NULL::unknown))) AS json_agg
                   FROM base_epigenome_tissue_group t
                  WHERE (t.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())), 'biological_group', json_build_object('name', 'Biological group', 'type', 'categorical_with_ontology', 'values', ( SELECT json_agg(json_build_object('value', c.biological_group, 'ontology', json_build_object('curie', NULL::text, 'url', NULL::text)) ORDER BY c.biological_group) AS json_agg
                   FROM base_epigenome_biological_group c
                  WHERE (c.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())), 'sample_type', json_build_object('name', 'Sample type', 'type', 'categorical', 'values', ( SELECT json_agg(c.sample_type ORDER BY c.sample_type) AS json_agg
                   FROM base_epigenome_sample_type c
                  WHERE (c.species_name = species.species_name)), 'default_set', json_build_object('type', 'exclude', 'values', json_build_array())))) AS payload
           FROM species
        )
 SELECT jsonb_pretty((json_agg(species_dimensions.payload))::jsonb) AS species_dimensions
   FROM species_dimensions;


ALTER TABLE public.metadata_dimensions OWNER TO "ensreg-usr";

--
-- Name: metadata_override; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.metadata_override (
    metadata_override_id uuid DEFAULT gen_random_uuid() NOT NULL,
    accession text NOT NULL,
    original_values jsonb NOT NULL,
    edited_values jsonb NOT NULL
);


ALTER TABLE public.metadata_override OWNER TO "ensreg-usr";

--
-- Name: multiome; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.multiome (
    experiment_id uuid NOT NULL,
    sn_atac_seq_id uuid NOT NULL,
    sn_rna_seq_id uuid,
    library_preparation character varying
);


ALTER TABLE public.multiome OWNER TO "ensreg-usr";

--
-- Name: open_chromatin_base_epigenome; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.open_chromatin_base_epigenome AS
 WITH slims_before_agg AS (
         SELECT curated_open_chromatin_assay_metadata.epigenome_id,
                CASE
                    WHEN (curated_open_chromatin_assay_metadata.organ_slims = ARRAY[]::text[]) THEN ARRAY['EMPTY'::text]
                    WHEN (curated_open_chromatin_assay_metadata.organ_slims IS NULL) THEN ARRAY['UNANNOTATED'::text]
                    ELSE curated_open_chromatin_assay_metadata.organ_slims
                END AS organs_mod,
                CASE
                    WHEN (curated_open_chromatin_assay_metadata.system_slims = ARRAY[]::text[]) THEN ARRAY['EMPTY'::text]
                    WHEN (curated_open_chromatin_assay_metadata.system_slims IS NULL) THEN ARRAY['UNANNOTATED'::text]
                    ELSE curated_open_chromatin_assay_metadata.system_slims
                END AS systems_mod
           FROM public.curated_open_chromatin_assay_metadata
        ), metadata_epig_with_ids AS (
         SELECT DISTINCT curated_open_chromatin_assay_metadata.species_name,
            curated_open_chromatin_assay_metadata.assembly_name,
            curated_open_chromatin_assay_metadata.epigenome_name,
            curated_open_chromatin_assay_metadata.epigenome_id,
            curated_open_chromatin_assay_metadata.epigenome_description,
            array_agg(DISTINCT curated_open_chromatin_assay_metadata.material) AS material,
            curated_open_chromatin_assay_metadata.term,
            curated_open_chromatin_assay_metadata.term_ontology,
            public.unnest_2d_1d(array_agg(DISTINCT slims_before_agg.organs_mod)) AS organs,
            public.unnest_2d_1d(array_agg(DISTINCT slims_before_agg.systems_mod)) AS systems,
            array_agg(DISTINCT curated_open_chromatin_assay_metadata.sex) AS sex,
            array_agg(DISTINCT curated_open_chromatin_assay_metadata.life_stage) AS life_stage,
            array_agg(DISTINCT curated_open_chromatin_assay_metadata.age ORDER BY curated_open_chromatin_assay_metadata.age) AS age,
            array_agg(DISTINCT curated_open_chromatin_assay_metadata.age_unit) AS age_unit
           FROM (public.curated_open_chromatin_assay_metadata
             JOIN slims_before_agg ON ((curated_open_chromatin_assay_metadata.epigenome_id = slims_before_agg.epigenome_id)))
          GROUP BY curated_open_chromatin_assay_metadata.species_name, curated_open_chromatin_assay_metadata.assembly_name, curated_open_chromatin_assay_metadata.epigenome_name, curated_open_chromatin_assay_metadata.epigenome_id, curated_open_chromatin_assay_metadata.epigenome_description, curated_open_chromatin_assay_metadata.term, curated_open_chromatin_assay_metadata.term_ontology
        ), slims_after_agg AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN (metadata_epig_with_ids_1.organs = ARRAY['EMPTY'::text]) THEN ARRAY[]::text[]
                    WHEN (metadata_epig_with_ids_1.organs = ARRAY['UNANNOTATED'::text]) THEN NULL::text[]
                    ELSE metadata_epig_with_ids_1.organs
                END AS organs,
                CASE
                    WHEN (metadata_epig_with_ids_1.systems = ARRAY['EMPTY'::text]) THEN ARRAY[]::text[]
                    WHEN (metadata_epig_with_ids_1.systems = ARRAY['UNANNOTATED'::text]) THEN NULL::text[]
                    ELSE metadata_epig_with_ids_1.systems
                END AS systems,
                CASE
                    WHEN ('unknown'::text = ANY (metadata_epig_with_ids_1.age)) THEN NULL::numeric[]
                    ELSE (metadata_epig_with_ids_1.age)::numeric[]
                END AS age,
            metadata_epig_with_ids_1.age_unit
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        ), handle_age_after_agg AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN ('unknown'::text = ANY (metadata_epig_with_ids_1.age)) THEN NULL::numeric[]
                    ELSE (metadata_epig_with_ids_1.age)::numeric[]
                END AS age
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        ), sort_agg_age AS (
         SELECT handle_age_after_agg.epigenome_id,
            ARRAY( SELECT unnest(handle_age_after_agg.age) AS unnest
                  ORDER BY (unnest(handle_age_after_agg.age))) AS age_sorted
           FROM handle_age_after_agg
        ), handle_sorted_age AS (
         SELECT sort_agg_age.epigenome_id,
                CASE
                    WHEN (ARRAY[]::numeric[] = sort_agg_age.age_sorted) THEN NULL::text
                    WHEN (array_length(sort_agg_age.age_sorted, 1) = 1) THEN ((sort_agg_age.age_sorted[1])::real)::text
                    ELSE ((sort_agg_age.age_sorted)::real[])::text
                END AS age
           FROM sort_agg_age
        ), handle_age_unit_after_agg AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN ('unknown'::text = ANY (metadata_epig_with_ids_1.age)) THEN NULL::text
                    WHEN ((('embryo'::text = ANY (metadata_epig_with_ids_1.life_stage)) OR ('embryonic'::text = ANY (metadata_epig_with_ids_1.life_stage))) AND ('day'::text = ANY (metadata_epig_with_ids_1.age_unit))) THEN 'days post fertilisation'::text
                    ELSE array_to_string(metadata_epig_with_ids_1.age_unit, ', '::text)
                END AS age_unit
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        ), handle_age_unit_singular_plural AS (
         SELECT handle_age_unit_after_agg.epigenome_id,
                CASE
                    WHEN ((handle_age_unit_after_agg.age_unit <> 'days post fertilisation'::text) AND (handle_age_unit_after_agg.age_unit <> 'thermal time'::text) AND (sort_agg_age.age_sorted[1] <> (1)::numeric)) THEN concat(handle_age_unit_after_agg.age_unit, 's')
                    ELSE handle_age_unit_after_agg.age_unit
                END AS age_unit
           FROM (handle_age_unit_after_agg
             JOIN sort_agg_age ON ((handle_age_unit_after_agg.epigenome_id = sort_agg_age.epigenome_id)))
        ), age_range AS (
         SELECT sort_agg_age.epigenome_id,
                CASE
                    WHEN (ARRAY[]::numeric[] = sort_agg_age.age_sorted) THEN NULL::text
                    WHEN (array_length(sort_agg_age.age_sorted, 1) = 1) THEN ((sort_agg_age.age_sorted[1])::real)::text
                    ELSE concat(((sort_agg_age.age_sorted[1])::real)::text, '-', ((sort_agg_age.age_sorted[array_upper(sort_agg_age.age_sorted, 1)])::real)::text)
                END AS age_range
           FROM sort_agg_age
        ), shorten_age_unit AS (
         SELECT handle_age_unit_after_agg.epigenome_id,
                CASE
                    WHEN (handle_age_unit_after_agg.age_unit = 'days post fertilisation'::text) THEN 'dpf'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'month'::text) THEN 'mo'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'year'::text) THEN 'y'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'week'::text) THEN 'w'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'day'::text) THEN 'd'::text
                    WHEN (handle_age_unit_after_agg.age_unit = 'thermal time'::text) THEN 'tt'::text
                    ELSE handle_age_unit_after_agg.age_unit
                END AS short_age_unit
           FROM handle_age_unit_after_agg
        ), shorten_sex AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['unknown'::text]) THEN NULL::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['mixed'::text]) THEN NULL::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['male'::text, 'female'::text]) THEN NULL::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] = ARRAY['male'::text]) THEN 'm'::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] = ARRAY['female'::text]) THEN 'f'::text
                    WHEN ((metadata_epig_with_ids_1.sex)::text[] = ARRAY['phenotypic'::text]) THEN NULL::text
                    ELSE 'Err: not contemplated case'::text
                END AS sex_for_label
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        ), lifestage_in_label AS (
         SELECT metadata_epig_with_ids_1.epigenome_id,
                CASE
                    WHEN ((((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['phenotypic'::text]) OR ((metadata_epig_with_ids_1.sex)::text[] @> ARRAY['unknown'::text])) AND (metadata_epig_with_ids_1.term = 'embryo'::text)) THEN metadata_epig_with_ids_1.life_stage
                    ELSE NULL::text[]
                END AS life_stage_info_for_label
           FROM metadata_epig_with_ids metadata_epig_with_ids_1
        )
 SELECT DISTINCT metadata_epig_with_ids.species_name,
    metadata_epig_with_ids.assembly_name,
    metadata_epig_with_ids.epigenome_id AS id,
    lower(array_to_string(metadata_epig_with_ids.material, ', '::text)) AS material,
    metadata_epig_with_ids.epigenome_name,
    metadata_epig_with_ids.term,
        CASE
            WHEN (metadata_epig_with_ids.term <> 'embryo'::text) THEN metadata_epig_with_ids.term
            ELSE NULL::text
        END AS term_for_label,
    metadata_epig_with_ids.term_ontology,
    array_to_string(metadata_epig_with_ids.sex, ', '::text) AS sex,
    shorten_sex.sex_for_label,
    array_to_string(metadata_epig_with_ids.life_stage, ', '::text) AS life_stage,
        CASE
            WHEN ((((metadata_epig_with_ids.sex)::text[] @> ARRAY['phenotypic'::text]) OR ((metadata_epig_with_ids.sex)::text[] @> ARRAY['unknown'::text])) AND (metadata_epig_with_ids.term = 'embryo'::text)) THEN array_to_string(metadata_epig_with_ids.life_stage, ', '::text)
            ELSE NULL::text
        END AS life_stage_for_label,
        CASE
            WHEN (handle_sorted_age.age IS NULL) THEN NULL::text
            ELSE concat(handle_sorted_age.age, ' ', handle_age_unit_singular_plural.age_unit)
        END AS extended_age,
        CASE
            WHEN (handle_sorted_age.age IS NULL) THEN NULL::text
            ELSE concat(age_range.age_range, ' ', shorten_age_unit.short_age_unit)
        END AS age,
        CASE
            WHEN (((metadata_epig_with_ids.assembly_name)::text = 'GRCm39'::text) AND (array_to_string(metadata_epig_with_ids.life_stage, ', '::text) = 'embryonic'::text) AND (age_range.age_range IS NOT NULL)) THEN concat('E', age_range.age_range)
            WHEN (handle_sorted_age.age IS NULL) THEN NULL::text
            ELSE concat(age_range.age_range, ' ', shorten_age_unit.short_age_unit)
        END AS age_for_label,
    slims_after_agg.organs,
    slims_after_agg.systems,
    biosample_term_group.term_group AS tissue_group,
    biosample_biological_group.biological_group,
    biosample_sample_type.sample_type
   FROM (((((((((metadata_epig_with_ids
     JOIN handle_sorted_age ON ((metadata_epig_with_ids.epigenome_id = handle_sorted_age.epigenome_id)))
     JOIN age_range ON ((metadata_epig_with_ids.epigenome_id = age_range.epigenome_id)))
     JOIN handle_age_unit_singular_plural ON ((metadata_epig_with_ids.epigenome_id = handle_age_unit_singular_plural.epigenome_id)))
     JOIN shorten_age_unit ON ((metadata_epig_with_ids.epigenome_id = shorten_age_unit.epigenome_id)))
     JOIN slims_after_agg ON ((metadata_epig_with_ids.epigenome_id = slims_after_agg.epigenome_id)))
     JOIN shorten_sex ON ((metadata_epig_with_ids.epigenome_id = shorten_sex.epigenome_id)))
     JOIN public.biosample_term_group ON ((metadata_epig_with_ids.epigenome_id = biosample_term_group.epigenome_id)))
     LEFT JOIN public.biosample_biological_group ON ((metadata_epig_with_ids.epigenome_id = biosample_biological_group.epigenome_id)))
     LEFT JOIN public.biosample_sample_type ON ((metadata_epig_with_ids.epigenome_id = biosample_sample_type.epigenome_id)))
  WHERE (((metadata_epig_with_ids.assembly_name)::text <> 'ARS-UCD1.3'::text) AND ((metadata_epig_with_ids.assembly_name)::text <> 'GRCg6a'::text) AND (metadata_epig_with_ids.term <> 'iPS-18c'::text));


ALTER TABLE public.open_chromatin_base_epigenome OWNER TO "ensreg-usr";

--
-- Name: posix_file; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.posix_file (
    posix_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    path text NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.posix_file OWNER TO "ensreg-usr";

--
-- Name: public_url; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.public_url (
    public_url_id uuid DEFAULT gen_random_uuid() NOT NULL,
    url text NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.public_url OWNER TO "ensreg-usr";

--
-- Name: quality_annotation; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.quality_annotation (
    quality_annotation_id uuid DEFAULT gen_random_uuid() NOT NULL,
    accession text NOT NULL,
    date date,
    quality_annotation_type public.quality_annotation_type NOT NULL,
    details jsonb NOT NULL
);


ALTER TABLE public.quality_annotation OWNER TO "ensreg-usr";

--
-- Name: read_file; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.read_file (
    split_order integer,
    technical_replicate integer,
    read_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    read_file_set_id uuid,
    file_id uuid NOT NULL,
    read_count integer,
    base_count bigint,
    paired_order integer,
    run_order public.run_order_type,
    run_id uuid,
    data_source_id uuid
);


ALTER TABLE public.read_file OWNER TO "ensreg-usr";

--
-- Name: read_file_data_source; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.read_file_data_source AS
 SELECT read_file.split_order,
    read_file.technical_replicate,
    read_file.read_file_id,
    read_file.read_file_set_id,
    read_file.file_id,
    read_file.read_count,
    read_file.base_count,
    read_file.paired_order,
    read_file.run_order,
    read_file.run_id,
    read_file.data_source_id,
    data_source.accession AS read_file_accession
   FROM (public.read_file
     LEFT JOIN public.data_source ON ((read_file.data_source_id = data_source.data_source_id)));


ALTER TABLE public.read_file_data_source OWNER TO "ensreg-usr";

--
-- Name: run; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.run (
    run_id uuid DEFAULT gen_random_uuid() NOT NULL,
    read_length integer NOT NULL,
    read_file_set_id uuid,
    data_source_id uuid,
    read_count integer NOT NULL,
    technical_replicate integer NOT NULL,
    run_type public.run_type NOT NULL
);


ALTER TABLE public.run OWNER TO "ensreg-usr";

--
-- Name: run_accession; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.run_accession AS
 SELECT run.run_id,
    run.run_type,
    run.read_length,
    run.read_file_set_id,
    run.data_source_id,
    run.read_count,
    run.technical_replicate,
    data_source.accession AS run_accession
   FROM (public.run
     LEFT JOIN public.data_source ON ((run.data_source_id = data_source.data_source_id)));


ALTER TABLE public.run_accession OWNER TO "ensreg-usr";

--
-- Name: read_file_metadata; Type: VIEW; Schema: public; Owner: ensreg-usr
--

CREATE VIEW public.read_file_metadata AS
 SELECT DISTINCT experiment_metadata.species_name,
    experiment_metadata.species_id,
    experiment_metadata.epigenome_group_description,
    experiment_metadata.epigenome_group_id,
    experiment_metadata.epigenome_accession,
    experiment_metadata.epigenome_name,
    experiment_metadata.epigenome_description,
    experiment_metadata.name,
    experiment_metadata.experiment_type,
    experiment_metadata.epigenome_id,
    experiment_metadata.experiment_id,
    experiment_metadata.data_source_id,
    experiment_metadata.replicate_set_id,
    experiment_metadata.replicate_set_type,
    experiment_metadata.experiment_target_type,
    experiment_metadata.experiment_target,
    experiment_metadata.replicate_set_accession,
    experiment_metadata.replicate_id,
    experiment_metadata.replicate_accession,
    experiment_metadata.biosample_set_id,
    experiment_metadata.biosample_set_type,
    experiment_metadata.accession,
    experiment_metadata.biosample_id,
    experiment_metadata.biosample_accession,
    experiment_metadata.biosample_alternative_accession,
    experiment_metadata.biomaterial_type,
    experiment_metadata.biosample_term,
    experiment_metadata.ontology_id,
    experiment_metadata.ontology_type,
    experiment_metadata.curie,
    experiment_metadata.organ_slims,
    experiment_metadata.cell_slims,
    experiment_metadata.developmental_slims,
    experiment_metadata.system_slims,
    experiment_metadata.synonyms,
    experiment_metadata.life_stage_id,
    experiment_metadata.life_stage_term,
    experiment_metadata.life_stage_ontology_relation,
    experiment_metadata.life_stage_ontology_id,
    experiment_metadata.life_stage_ontology_type,
    experiment_metadata.life_stage_ontology_curie,
    experiment_metadata.age_at_collection,
    experiment_metadata.age_at_collection_unit,
    experiment_metadata.time_post_fertilisation,
    experiment_metadata.time_post_fertilisation_unit,
    experiment_metadata.thermal_time,
    experiment_metadata.perturbed,
    experiment_metadata.treatments,
    experiment_metadata.health_status,
    experiment_metadata.disease_term_id,
    experiment_metadata.disease_term_name,
    experiment_metadata.genetic_modifications,
    experiment_metadata.biosource_accession,
    experiment_metadata.biosource_alternative_accession,
    experiment_metadata.age,
    experiment_metadata.age_unit,
    experiment_metadata.sex,
    library_data_source.library_accession,
    library_data_source.read_file_set_id,
    run_accession.technical_replicate,
    run_accession.run_type,
    run_accession.read_length,
    run_accession.read_count,
    run_accession.run_id,
    read_file_data_source.run_order,
    read_file_data_source.read_file_accession,
    read_file_data_source.read_file_id,
    file.file_id,
    file.size,
    file.md5sum,
    public_url.url,
    run_accession.run_accession,
    s3_object.key
   FROM (((((((public.experiment_metadata
     JOIN public.replicate ON (((experiment_metadata.replicate_id = replicate.replicate_id) AND (replicate.biosample_set_id = experiment_metadata.biosample_set_id))))
     JOIN public.library_data_source ON ((replicate.read_file_set_id = library_data_source.read_file_set_id)))
     JOIN public.run_accession ON ((library_data_source.read_file_set_id = run_accession.read_file_set_id)))
     JOIN public.read_file_data_source ON ((run_accession.run_id = read_file_data_source.run_id)))
     JOIN public.file ON ((read_file_data_source.file_id = file.file_id)))
     LEFT JOIN public.public_url ON ((file.file_id = public_url.file_id)))
     LEFT JOIN public.s3_object ON ((file.file_id = s3_object.file_id)));


ALTER TABLE public.read_file_metadata OWNER TO "ensreg-usr";

--
-- Name: rna_seq; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.rna_seq (
    experiment_id uuid NOT NULL,
    replicate_set_id uuid NOT NULL,
    library_preparation character varying
);


ALTER TABLE public.rna_seq OWNER TO "ensreg-usr";

--
-- Name: run_alignment_task; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.run_alignment_task (
    run_id uuid NOT NULL,
    alignment_task_id uuid NOT NULL
);


ALTER TABLE public.run_alignment_task OWNER TO "ensreg-usr";

--
-- Name: track; Type: TABLE; Schema: public; Owner: ensreg-usr
--

CREATE TABLE public.track (
    metadata jsonb,
    epigenome_id uuid NOT NULL,
    track_id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.track OWNER TO "ensreg-usr";

--
-- Name: quality_annotation accession_date_details_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.quality_annotation
    ADD CONSTRAINT accession_date_details_key UNIQUE (accession, date, details);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: alignment_file alignment_file_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_pkey PRIMARY KEY (alignment_file_id);


--
-- Name: alignment_task alignment_task_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.alignment_task
    ADD CONSTRAINT alignment_task_pkey PRIMARY KEY (alignment_task_id);


--
-- Name: analysis_file analysis_file_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT analysis_file_pkey PRIMARY KEY (analysis_file_id);


--
-- Name: archive archive_abbreviation_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_abbreviation_key UNIQUE (abbreviation);


--
-- Name: archive archive_name_website_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_name_website_key UNIQUE (name, website);


--
-- Name: archive archive_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_pkey PRIMARY KEY (archive_id);


--
-- Name: assembly assembly_ensembl_accession_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.assembly
    ADD CONSTRAINT assembly_ensembl_accession_key UNIQUE (ensembl_accession);


--
-- Name: assembly assembly_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.assembly
    ADD CONSTRAINT assembly_pkey PRIMARY KEY (assembly_id);


--
-- Name: atac_seq atac_seq_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.atac_seq
    ADD CONSTRAINT atac_seq_pkey PRIMARY KEY (experiment_id);


--
-- Name: barcode_file barcode_file_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.barcode_file
    ADD CONSTRAINT barcode_file_pkey PRIMARY KEY (barcode_file_id);


--
-- Name: biosample biosample_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_pkey PRIMARY KEY (biosample_id);


--
-- Name: biosample_set_biosample biosample_set_biosample_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample_set_biosample
    ADD CONSTRAINT biosample_set_biosample_pkey PRIMARY KEY (biosample_set_id, biosample_id);


--
-- Name: biosample_set biosample_set_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample_set
    ADD CONSTRAINT biosample_set_pkey PRIMARY KEY (biosample_set_id);


--
-- Name: biosource biosource_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosource
    ADD CONSTRAINT biosource_pkey PRIMARY KEY (biosource_id);


--
-- Name: bucket bucket_name_endpoint_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.bucket
    ADD CONSTRAINT bucket_name_endpoint_key UNIQUE (name, endpoint);


--
-- Name: bucket bucket_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.bucket
    ADD CONSTRAINT bucket_pkey PRIMARY KEY (bucket_id);


--
-- Name: chip_seq chip_seq_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_pkey PRIMARY KEY (experiment_id);


--
-- Name: data_source data_source_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.data_source
    ADD CONSTRAINT data_source_pkey PRIMARY KEY (data_source_id);


--
-- Name: dnase_seq dnase_seq_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.dnase_seq
    ADD CONSTRAINT dnase_seq_pkey PRIMARY KEY (experiment_id);


--
-- Name: epigenome_group epigenome_group_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.epigenome_group
    ADD CONSTRAINT epigenome_group_pkey PRIMARY KEY (epigenome_group_id);


--
-- Name: epigenome epigenome_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_pkey PRIMARY KEY (epigenome_id);


--
-- Name: experiment experiment_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.experiment
    ADD CONSTRAINT experiment_pkey PRIMARY KEY (experiment_id);


--
-- Name: file file_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (file_id);


--
-- Name: histone_target histone_target_name_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.histone_target
    ADD CONSTRAINT histone_target_name_key UNIQUE (name);


--
-- Name: histone_target histone_target_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.histone_target
    ADD CONSTRAINT histone_target_pkey PRIMARY KEY (histone_target_id);


--
-- Name: inclusion_list inclusion_list_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.inclusion_list
    ADD CONSTRAINT inclusion_list_pkey PRIMARY KEY (inclusion_list_id);


--
-- Name: life_stage life_stage_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.life_stage
    ADD CONSTRAINT life_stage_pkey PRIMARY KEY (life_stage_id);


--
-- Name: life_stage life_stage_term_ontology_relation_ontology_id_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.life_stage
    ADD CONSTRAINT life_stage_term_ontology_relation_ontology_id_key UNIQUE (term, ontology_id, ontology_relation);


--
-- Name: mask_file mask_file_assembly_id_file_id_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.mask_file
    ADD CONSTRAINT mask_file_assembly_id_file_id_key UNIQUE (assembly_id, file_id);


--
-- Name: mask_file mask_file_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.mask_file
    ADD CONSTRAINT mask_file_pkey PRIMARY KEY (mask_file_id);


--
-- Name: metadata_override metadata_override_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.metadata_override
    ADD CONSTRAINT metadata_override_pkey PRIMARY KEY (metadata_override_id);


--
-- Name: multiome multiome_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.multiome
    ADD CONSTRAINT multiome_pkey PRIMARY KEY (experiment_id);


--
-- Name: multiome multiome_sn_atac_seq_id_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.multiome
    ADD CONSTRAINT multiome_sn_atac_seq_id_key UNIQUE (sn_atac_seq_id);


--
-- Name: multiome multiome_sn_rna_seq_id_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.multiome
    ADD CONSTRAINT multiome_sn_rna_seq_id_key UNIQUE (sn_rna_seq_id);


--
-- Name: ontology ontology_ontology_type_curie_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.ontology
    ADD CONSTRAINT ontology_ontology_type_curie_key UNIQUE (ontology_type, curie);


--
-- Name: ontology ontology_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.ontology
    ADD CONSTRAINT ontology_pkey PRIMARY KEY (ontology_id);


--
-- Name: posix_file posix_file_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.posix_file
    ADD CONSTRAINT posix_file_pkey PRIMARY KEY (posix_file_id);


--
-- Name: public_url public_url_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.public_url
    ADD CONSTRAINT public_url_pkey PRIMARY KEY (public_url_id);


--
-- Name: quality_annotation quality_annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.quality_annotation
    ADD CONSTRAINT quality_annotation_pkey PRIMARY KEY (quality_annotation_id);


--
-- Name: read_file read_file_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_pkey PRIMARY KEY (read_file_id);


--
-- Name: read_file_set read_file_set_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.read_file_set
    ADD CONSTRAINT read_file_set_pkey PRIMARY KEY (read_file_set_id);


--
-- Name: replicate replicate_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_pkey PRIMARY KEY (replicate_id);


--
-- Name: replicate_set replicate_set_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.replicate_set
    ADD CONSTRAINT replicate_set_pkey PRIMARY KEY (replicate_set_id);


--
-- Name: rna_seq rna_seq_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.rna_seq
    ADD CONSTRAINT rna_seq_pkey PRIMARY KEY (experiment_id);


--
-- Name: rna_seq rna_seq_replicate_set_id_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.rna_seq
    ADD CONSTRAINT rna_seq_replicate_set_id_key UNIQUE (replicate_set_id);


--
-- Name: run_alignment_task run_alignment_task_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.run_alignment_task
    ADD CONSTRAINT run_alignment_task_pkey PRIMARY KEY (run_id, alignment_task_id);


--
-- Name: run run_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_pkey PRIMARY KEY (run_id);


--
-- Name: s3_object s3_object_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.s3_object
    ADD CONSTRAINT s3_object_pkey PRIMARY KEY (s3_object_id);


--
-- Name: species species_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_pkey PRIMARY KEY (species_id);


--
-- Name: tf_target tf_target_name_gene_stable_id_key; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.tf_target
    ADD CONSTRAINT tf_target_name_gene_stable_id_key UNIQUE (name, gene_stable_id);


--
-- Name: tf_target tf_target_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.tf_target
    ADD CONSTRAINT tf_target_pkey PRIMARY KEY (tf_target_id);


--
-- Name: track track_pkey; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_pkey PRIMARY KEY (track_id);


--
-- Name: alignment_file uq_alignment_file_assembly_id_read_file_set_id_file_id; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT uq_alignment_file_assembly_id_read_file_set_id_file_id UNIQUE (assembly_id, read_file_set_id, file_id);


--
-- Name: analysis_file uq_analysis_file_assembly_id_experiment_id_analysis_type; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT uq_analysis_file_assembly_id_experiment_id_analysis_type UNIQUE (assembly_id, experiment_id, analysis_type);


--
-- Name: atac_seq uq_atac_seq_replicate_set_id; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.atac_seq
    ADD CONSTRAINT uq_atac_seq_replicate_set_id UNIQUE (replicate_set_id);


--
-- Name: chip_seq uq_chip_seq_signal; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT uq_chip_seq_signal UNIQUE (signal);


--
-- Name: dnase_seq uq_dnase_seq_replicate_set_id; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.dnase_seq
    ADD CONSTRAINT uq_dnase_seq_replicate_set_id UNIQUE (replicate_set_id);


--
-- Name: run uq_run_read_file_set_id_technical_replicate; Type: CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT uq_run_read_file_set_id_technical_replicate UNIQUE (read_file_set_id, technical_replicate);


--
-- Name: ix_alignment_file_alignment_task_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_alignment_file_alignment_task_id ON public.alignment_file USING btree (alignment_task_id);


--
-- Name: ix_alignment_file_assembly_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_alignment_file_assembly_id ON public.alignment_file USING btree (assembly_id);


--
-- Name: ix_alignment_file_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_alignment_file_file_id ON public.alignment_file USING btree (file_id);


--
-- Name: ix_alignment_file_read_file_set_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_alignment_file_read_file_set_id ON public.alignment_file USING btree (read_file_set_id);


--
-- Name: ix_analysis_file_assembly_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_analysis_file_assembly_id ON public.analysis_file USING btree (assembly_id);


--
-- Name: ix_analysis_file_experiment_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_analysis_file_experiment_id ON public.analysis_file USING btree (experiment_id);


--
-- Name: ix_analysis_file_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_analysis_file_file_id ON public.analysis_file USING btree (file_id);


--
-- Name: ix_assembly_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_assembly_file_id ON public.assembly USING btree (file_id);


--
-- Name: ix_assembly_species_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_assembly_species_id ON public.assembly USING btree (species_id);


--
-- Name: ix_barcode_file_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_barcode_file_data_source_id ON public.barcode_file USING btree (data_source_id);


--
-- Name: ix_barcode_file_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_barcode_file_file_id ON public.barcode_file USING btree (file_id);


--
-- Name: ix_barcode_file_run_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_barcode_file_run_id ON public.barcode_file USING btree (run_id);


--
-- Name: ix_biosample_alternative_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosample_alternative_data_source_id ON public.biosample USING btree (alternative_data_source_id);


--
-- Name: ix_biosample_biosource_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosample_biosource_id ON public.biosample USING btree (biosource_id);


--
-- Name: ix_biosample_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosample_data_source_id ON public.biosample USING btree (data_source_id);


--
-- Name: ix_biosample_life_stage_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosample_life_stage_id ON public.biosample USING btree (life_stage_id);


--
-- Name: ix_biosample_ontology_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosample_ontology_id ON public.biosample USING btree (ontology_id);


--
-- Name: ix_biosample_set_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosample_set_data_source_id ON public.biosample_set USING btree (data_source_id);


--
-- Name: ix_biosource_alternative_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosource_alternative_data_source_id ON public.biosource USING btree (alternative_data_source_id);


--
-- Name: ix_biosource_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosource_data_source_id ON public.biosource USING btree (data_source_id);


--
-- Name: ix_biosource_life_stage_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_biosource_life_stage_id ON public.biosource USING btree (life_stage_id);


--
-- Name: ix_chip_seq_control; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_chip_seq_control ON public.chip_seq USING btree (control);


--
-- Name: ix_chip_seq_histone_target_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_chip_seq_histone_target_id ON public.chip_seq USING btree (histone_target_id);


--
-- Name: ix_chip_seq_tf_target_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_chip_seq_tf_target_id ON public.chip_seq USING btree (tf_target_id);


--
-- Name: ix_data_source_accession; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_data_source_accession ON public.data_source USING btree (accession);


--
-- Name: ix_data_source_archive_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_data_source_archive_id ON public.data_source USING btree (archive_id);


--
-- Name: ix_epigenome_alternative_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_epigenome_alternative_data_source_id ON public.epigenome USING btree (alternative_data_source_id);


--
-- Name: ix_epigenome_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_epigenome_data_source_id ON public.epigenome USING btree (data_source_id);


--
-- Name: ix_epigenome_epigenome_group_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_epigenome_epigenome_group_id ON public.epigenome USING btree (epigenome_group_id);


--
-- Name: ix_epigenome_group_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_epigenome_group_data_source_id ON public.epigenome_group USING btree (data_source_id);


--
-- Name: ix_epigenome_species_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_epigenome_species_id ON public.epigenome USING btree (species_id);


--
-- Name: ix_experiment_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_experiment_data_source_id ON public.experiment USING btree (data_source_id);


--
-- Name: ix_experiment_epigenome_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_experiment_epigenome_id ON public.experiment USING btree (epigenome_id);


--
-- Name: ix_file_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_file_data_source_id ON public.file USING btree (data_source_id);


--
-- Name: ix_inclusion_list_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_inclusion_list_file_id ON public.inclusion_list USING btree (file_id);


--
-- Name: ix_life_stage_ontology_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_life_stage_ontology_id ON public.life_stage USING btree (ontology_id);


--
-- Name: ix_mask_file_assembly_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_mask_file_assembly_id ON public.mask_file USING btree (assembly_id);


--
-- Name: ix_mask_file_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_mask_file_file_id ON public.mask_file USING btree (file_id);


--
-- Name: ix_metadata_override_accession; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_metadata_override_accession ON public.metadata_override USING btree (accession);


--
-- Name: ix_posix_file_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_posix_file_file_id ON public.posix_file USING btree (file_id);


--
-- Name: ix_public_url_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_public_url_file_id ON public.public_url USING btree (file_id);


--
-- Name: ix_quality_annotation_accession; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_quality_annotation_accession ON public.quality_annotation USING btree (accession);


--
-- Name: ix_read_file_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_read_file_data_source_id ON public.read_file USING btree (data_source_id);


--
-- Name: ix_read_file_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_read_file_file_id ON public.read_file USING btree (file_id);


--
-- Name: ix_read_file_read_file_set_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_read_file_read_file_set_id ON public.read_file USING btree (read_file_set_id);


--
-- Name: ix_read_file_run_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_read_file_run_id ON public.read_file USING btree (run_id);


--
-- Name: ix_read_file_set_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_read_file_set_data_source_id ON public.read_file_set USING btree (data_source_id);


--
-- Name: ix_replicate_biosample_set_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_replicate_biosample_set_id ON public.replicate USING btree (biosample_set_id);


--
-- Name: ix_replicate_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_replicate_data_source_id ON public.replicate USING btree (data_source_id);


--
-- Name: ix_replicate_read_file_set_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_replicate_read_file_set_id ON public.replicate USING btree (read_file_set_id);


--
-- Name: ix_replicate_replicate_set_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_replicate_replicate_set_id ON public.replicate USING btree (replicate_set_id);


--
-- Name: ix_replicate_set_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_replicate_set_data_source_id ON public.replicate_set USING btree (data_source_id);


--
-- Name: ix_run_data_source_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_run_data_source_id ON public.run USING btree (data_source_id);


--
-- Name: ix_run_read_file_set_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_run_read_file_set_id ON public.run USING btree (read_file_set_id);


--
-- Name: ix_s3_object_bucket_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_s3_object_bucket_id ON public.s3_object USING btree (bucket_id);


--
-- Name: ix_s3_object_file_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_s3_object_file_id ON public.s3_object USING btree (file_id);


--
-- Name: ix_track_epigenome_id; Type: INDEX; Schema: public; Owner: ensreg-usr
--

CREATE INDEX ix_track_epigenome_id ON public.track USING btree (epigenome_id);


--
-- Name: alignment_file alignment_file_alignment_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_alignment_task_id_fkey FOREIGN KEY (alignment_task_id) REFERENCES public.alignment_task(alignment_task_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: alignment_file alignment_file_assembly_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_assembly_id_fkey FOREIGN KEY (assembly_id) REFERENCES public.assembly(assembly_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: alignment_file alignment_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: alignment_file alignment_file_read_file_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_read_file_set_id_fkey FOREIGN KEY (read_file_set_id) REFERENCES public.read_file_set(read_file_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: analysis_file analysis_file_assembly_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT analysis_file_assembly_id_fkey FOREIGN KEY (assembly_id) REFERENCES public.assembly(assembly_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: analysis_file analysis_file_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT analysis_file_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: analysis_file analysis_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT analysis_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: assembly assembly_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.assembly
    ADD CONSTRAINT assembly_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: assembly assembly_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.assembly
    ADD CONSTRAINT assembly_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(species_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: atac_seq atac_seq_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.atac_seq
    ADD CONSTRAINT atac_seq_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: atac_seq atac_seq_replicate_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.atac_seq
    ADD CONSTRAINT atac_seq_replicate_set_id_fkey FOREIGN KEY (replicate_set_id) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: barcode_file barcode_file_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.barcode_file
    ADD CONSTRAINT barcode_file_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: barcode_file barcode_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.barcode_file
    ADD CONSTRAINT barcode_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: barcode_file barcode_file_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.barcode_file
    ADD CONSTRAINT barcode_file_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.run(run_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_alternative_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_alternative_data_source_id_fkey FOREIGN KEY (alternative_data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_biosource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_biosource_id_fkey FOREIGN KEY (biosource_id) REFERENCES public.biosource(biosource_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_life_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_life_stage_id_fkey FOREIGN KEY (life_stage_id) REFERENCES public.life_stage(life_stage_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_ontology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_ontology_id_fkey FOREIGN KEY (ontology_id) REFERENCES public.ontology(ontology_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample_set_biosample biosample_set_biosample_biosample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample_set_biosample
    ADD CONSTRAINT biosample_set_biosample_biosample_id_fkey FOREIGN KEY (biosample_id) REFERENCES public.biosample(biosample_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample_set_biosample biosample_set_biosample_biosample_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample_set_biosample
    ADD CONSTRAINT biosample_set_biosample_biosample_set_id_fkey FOREIGN KEY (biosample_set_id) REFERENCES public.biosample_set(biosample_set_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample_set biosample_set_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosample_set
    ADD CONSTRAINT biosample_set_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosource biosource_alternative_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosource
    ADD CONSTRAINT biosource_alternative_data_source_id_fkey FOREIGN KEY (alternative_data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosource biosource_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosource
    ADD CONSTRAINT biosource_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosource biosource_life_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.biosource
    ADD CONSTRAINT biosource_life_stage_id_fkey FOREIGN KEY (life_stage_id) REFERENCES public.life_stage(life_stage_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_control_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_control_fkey FOREIGN KEY (control) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_histone_target_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_histone_target_id_fkey FOREIGN KEY (histone_target_id) REFERENCES public.histone_target(histone_target_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_signal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_signal_fkey FOREIGN KEY (signal) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_tf_target_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_tf_target_id_fkey FOREIGN KEY (tf_target_id) REFERENCES public.tf_target(tf_target_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: data_source data_source_archive_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.data_source
    ADD CONSTRAINT data_source_archive_id_fkey FOREIGN KEY (archive_id) REFERENCES public.archive(archive_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: dnase_seq dnase_seq_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.dnase_seq
    ADD CONSTRAINT dnase_seq_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: dnase_seq dnase_seq_replicate_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.dnase_seq
    ADD CONSTRAINT dnase_seq_replicate_set_id_fkey FOREIGN KEY (replicate_set_id) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome epigenome_alternative_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_alternative_data_source_id_fkey FOREIGN KEY (alternative_data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome epigenome_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome epigenome_epigenome_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_epigenome_group_id_fkey FOREIGN KEY (epigenome_group_id) REFERENCES public.epigenome_group(epigenome_group_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome_group epigenome_group_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.epigenome_group
    ADD CONSTRAINT epigenome_group_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome epigenome_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(species_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: experiment experiment_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.experiment
    ADD CONSTRAINT experiment_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: experiment experiment_epigenome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.experiment
    ADD CONSTRAINT experiment_epigenome_id_fkey FOREIGN KEY (epigenome_id) REFERENCES public.epigenome(epigenome_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: file file_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inclusion_list inclusion_list_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.inclusion_list
    ADD CONSTRAINT inclusion_list_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: life_stage life_stage_ontology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.life_stage
    ADD CONSTRAINT life_stage_ontology_id_fkey FOREIGN KEY (ontology_id) REFERENCES public.ontology(ontology_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: mask_file mask_file_assembly_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.mask_file
    ADD CONSTRAINT mask_file_assembly_id_fkey FOREIGN KEY (assembly_id) REFERENCES public.assembly(assembly_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: mask_file mask_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.mask_file
    ADD CONSTRAINT mask_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: multiome multiome_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.multiome
    ADD CONSTRAINT multiome_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: multiome multiome_sn_atac_seq_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.multiome
    ADD CONSTRAINT multiome_sn_atac_seq_id_fkey FOREIGN KEY (sn_atac_seq_id) REFERENCES public.replicate_set(replicate_set_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: multiome multiome_sn_rna_seq_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.multiome
    ADD CONSTRAINT multiome_sn_rna_seq_id_fkey FOREIGN KEY (sn_rna_seq_id) REFERENCES public.replicate_set(replicate_set_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: posix_file posix_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.posix_file
    ADD CONSTRAINT posix_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: public_url public_url_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.public_url
    ADD CONSTRAINT public_url_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file read_file_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file read_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file read_file_read_file_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_read_file_set_id_fkey FOREIGN KEY (read_file_set_id) REFERENCES public.read_file_set(read_file_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file read_file_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.run(run_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file_set read_file_set_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.read_file_set
    ADD CONSTRAINT read_file_set_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate replicate_biosample_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_biosample_set_id_fkey FOREIGN KEY (biosample_set_id) REFERENCES public.biosample_set(biosample_set_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate replicate_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate replicate_read_file_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_read_file_set_id_fkey FOREIGN KEY (read_file_set_id) REFERENCES public.read_file_set(read_file_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate replicate_replicate_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_replicate_set_id_fkey FOREIGN KEY (replicate_set_id) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate_set replicate_set_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.replicate_set
    ADD CONSTRAINT replicate_set_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rna_seq rna_seq_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.rna_seq
    ADD CONSTRAINT rna_seq_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rna_seq rna_seq_replicate_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.rna_seq
    ADD CONSTRAINT rna_seq_replicate_set_id_fkey FOREIGN KEY (replicate_set_id) REFERENCES public.replicate_set(replicate_set_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: run_alignment_task run_alignment_task_alignment_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.run_alignment_task
    ADD CONSTRAINT run_alignment_task_alignment_task_id_fkey FOREIGN KEY (alignment_task_id) REFERENCES public.alignment_task(alignment_task_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: run_alignment_task run_alignment_task_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.run_alignment_task
    ADD CONSTRAINT run_alignment_task_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.run(run_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: run run_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: run run_read_file_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_read_file_set_id_fkey FOREIGN KEY (read_file_set_id) REFERENCES public.read_file_set(read_file_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: s3_object s3_object_bucket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.s3_object
    ADD CONSTRAINT s3_object_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES public.bucket(bucket_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: s3_object s3_object_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.s3_object
    ADD CONSTRAINT s3_object_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: track track_epigenome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ensreg-usr
--

ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_epigenome_id_fkey FOREIGN KEY (epigenome_id) REFERENCES public.epigenome(epigenome_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict 2ALktoMjlcQC9npvHKuhbuJoLT9RR2e9SgJdAgOo26ErKorhweOQcCmw4bSiexV
