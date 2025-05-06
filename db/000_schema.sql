--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3 (Debian 14.3-1.pgdg110+1)
-- Dumped by pg_dump version 14.3 (Debian 14.3-1.pgdg110+1)

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
-- Name: age_unit_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.age_unit_type AS ENUM (
    'day',
    'hour',
    'month',
    'thermal_time',
    'week',
    'year'
);


ALTER TYPE public.age_unit_type OWNER TO regulation_usr;

--
-- Name: analysis_type; Type: TYPE; Schema: public; Owner: regulation_usr
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


ALTER TYPE public.analysis_type OWNER TO regulation_usr;

--
-- Name: biomaterial_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.biomaterial_type AS ENUM (
    'cell_line',
    'primary_cell',
    'primary_cell_culture',
    'primary_tissue'
);


ALTER TYPE public.biomaterial_type OWNER TO regulation_usr;

--
-- Name: biosample_set_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.biosample_set_type AS ENUM (
    'individual',
    'pool_of_specimens'
);


ALTER TYPE public.biosample_set_type OWNER TO regulation_usr;

--
-- Name: data_source_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.data_source_type AS ENUM (
    'entrypoint',
    'embedded'
);


ALTER TYPE public.data_source_type OWNER TO regulation_usr;

--
-- Name: experiment_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.experiment_type AS ENUM (
    'chip_seq',
    'atac_seq',
    'dnase_seq'
);


ALTER TYPE public.experiment_type OWNER TO regulation_usr;

--
-- Name: file_system_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.file_system_type AS ENUM (
    's3_object',
    'posix_file',
    'public_url'
);


ALTER TYPE public.file_system_type OWNER TO regulation_usr;

--
-- Name: file_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.file_type AS ENUM (
    'bam',
    'bed',
    'bigwig',
    'fasta',
    'fastq',
    'txt'
);


ALTER TYPE public.file_type OWNER TO regulation_usr;

--
-- Name: histone_target_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.histone_target_type AS ENUM (
    'H3K4me3',
    'H3K27ac',
    'H3K27me3',
    'H3K4me1'
);


ALTER TYPE public.histone_target_type OWNER TO regulation_usr;

--
-- Name: mark_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.mark_type AS ENUM (
    'broad',
    'narrow'
);


ALTER TYPE public.mark_type OWNER TO regulation_usr;

--
-- Name: ontology_relation_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.ontology_relation_type AS ENUM (
    'child_of',
    'direct'
);


ALTER TYPE public.ontology_relation_type OWNER TO regulation_usr;

--
-- Name: ontology_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.ontology_type AS ENUM (
    'CL',
    'CLO',
    'EFO',
    'NTR',
    'UBERON'
);


ALTER TYPE public.ontology_type OWNER TO regulation_usr;

--
-- Name: quality_annotation_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.quality_annotation_type AS ENUM (
    'exclude',
    'warn',
    'pass'
);


ALTER TYPE public.quality_annotation_type OWNER TO regulation_usr;

--
-- Name: run_grouping_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.run_grouping_type AS ENUM (
    'run_type_read_length'
);


ALTER TYPE public.run_grouping_type OWNER TO regulation_usr;

--
-- Name: run_order_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.run_order_type AS ENUM (
    'SE',
    'PE1',
    'PE2'
);


ALTER TYPE public.run_order_type OWNER TO regulation_usr;

--
-- Name: run_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.run_type AS ENUM (
    'SE',
    'PE'
);


ALTER TYPE public.run_type OWNER TO regulation_usr;

--
-- Name: sex_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.sex_type AS ENUM (
    'female',
    'male',
    'mixed',
    'phenotypic',
    'unknown'
);


ALTER TYPE public.sex_type OWNER TO regulation_usr;

--
-- Name: target_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.target_type AS ENUM (
    'histone',
    'tf'
);


ALTER TYPE public.target_type OWNER TO regulation_usr;

--
-- Name: tf_target_type; Type: TYPE; Schema: public; Owner: regulation_usr
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


ALTER TYPE public.tf_target_type OWNER TO regulation_usr;

--
-- Name: time_post_fertilisation_unit_type; Type: TYPE; Schema: public; Owner: regulation_usr
--

CREATE TYPE public.time_post_fertilisation_unit_type AS ENUM (
    'day',
    'week',
    'hour'
);


ALTER TYPE public.time_post_fertilisation_unit_type OWNER TO regulation_usr;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO regulation_usr;

--
-- Name: alignment_file; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.alignment_file (
    read_file_set_id uuid NOT NULL,
    alignment_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    assembly_id uuid NOT NULL,
    file_id uuid NOT NULL,
    alignment_task_id uuid
);


ALTER TABLE public.alignment_file OWNER TO regulation_usr;

--
-- Name: alignment_task; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.alignment_task (
    alignment_task_id uuid DEFAULT gen_random_uuid() NOT NULL,
    run_grouping public.run_grouping_type NOT NULL
);


ALTER TABLE public.alignment_task OWNER TO regulation_usr;

--
-- Name: analysis_file; Type: TABLE; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.analysis_file OWNER TO regulation_usr;

--
-- Name: assembly; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.assembly (
    ensembl_accession character varying,
    assembly_id uuid DEFAULT gen_random_uuid() NOT NULL,
    file_id uuid NOT NULL,
    species_id uuid NOT NULL
);


ALTER TABLE public.assembly OWNER TO regulation_usr;

--
-- Name: atac_seq; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.atac_seq (
    experiment_id uuid NOT NULL,
    replicate_set_id uuid NOT NULL
);


ALTER TABLE public.atac_seq OWNER TO regulation_usr;

--
-- Name: chip_seq; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.chip_seq (
    experiment_id uuid NOT NULL,
    control uuid,
    signal uuid NOT NULL,
    target_type public.target_type NOT NULL,
    histone_target_id uuid,
    tf_target_id uuid
);


ALTER TABLE public.chip_seq OWNER TO regulation_usr;

--
-- Name: data_source; Type: TABLE; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.data_source OWNER TO regulation_usr;

--
-- Name: dnase_seq; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.dnase_seq (
    experiment_id uuid NOT NULL,
    replicate_set_id uuid NOT NULL
);


ALTER TABLE public.dnase_seq OWNER TO regulation_usr;

--
-- Name: epigenome; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.epigenome (
    name text NOT NULL,
    description text NOT NULL,
    epigenome_id uuid DEFAULT gen_random_uuid() NOT NULL,
    epigenome_group_id uuid NOT NULL,
    species_id uuid NOT NULL,
    data_source_id uuid,
    alternative_data_source_id uuid
);


ALTER TABLE public.epigenome OWNER TO regulation_usr;

--
-- Name: epigenome_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.epigenome_data_source OWNER TO regulation_usr;

--
-- Name: epigenome_group; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.epigenome_group (
    description character varying,
    epigenome_group_id uuid DEFAULT gen_random_uuid() NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.epigenome_group OWNER TO regulation_usr;

--
-- Name: experiment; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.experiment (
    name text NOT NULL,
    experiment_type public.experiment_type NOT NULL,
    epigenome_id uuid NOT NULL,
    experiment_id uuid DEFAULT gen_random_uuid() NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.experiment OWNER TO regulation_usr;

--
-- Name: replicate_set; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.replicate_set (
    replicate_set_id uuid DEFAULT gen_random_uuid() NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.replicate_set OWNER TO regulation_usr;

--
-- Name: experiment_control_target_info; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.experiment_control_target_info OWNER TO regulation_usr;

--
-- Name: replicate_set_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.replicate_set_data_source AS
 SELECT replicate_set.replicate_set_id,
    replicate_set.data_source_id,
    data_source.accession AS replicate_set_accession
   FROM (public.replicate_set
     LEFT JOIN public.data_source ON ((replicate_set.data_source_id = data_source.data_source_id)));


ALTER TABLE public.replicate_set_data_source OWNER TO regulation_usr;

--
-- Name: experiment_control_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.experiment_control_data_source OWNER TO regulation_usr;

--
-- Name: histone_target; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.histone_target (
    histone_target_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name public.histone_target_type NOT NULL,
    mark_type public.mark_type NOT NULL
);


ALTER TABLE public.histone_target OWNER TO regulation_usr;

--
-- Name: tf_target; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.tf_target (
    tf_target_id uuid DEFAULT gen_random_uuid() NOT NULL,
    name public.tf_target_type NOT NULL,
    gene_stable_id text
);


ALTER TABLE public.tf_target OWNER TO regulation_usr;

--
-- Name: experiment_signal_target_info; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.experiment_signal_target_info OWNER TO regulation_usr;

--
-- Name: experiment_signal_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.experiment_signal_data_source OWNER TO regulation_usr;

--
-- Name: species; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.species (
    name text NOT NULL,
    species_id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.species OWNER TO regulation_usr;

--
-- Name: experiment_signal_and_control_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.experiment_signal_and_control_data_source OWNER TO regulation_usr;

--
-- Name: file; Type: TABLE; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.file OWNER TO regulation_usr;

--
-- Name: s3_object; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.s3_object (
    s3_object_id uuid DEFAULT gen_random_uuid() NOT NULL,
    key text NOT NULL,
    bucket_id uuid NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.s3_object OWNER TO regulation_usr;

--
-- Name: analysis_file_experiment_info; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.analysis_file_experiment_info OWNER TO regulation_usr;

--
-- Name: analysis_file_info_with_checks; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.analysis_file_info_with_checks OWNER TO regulation_usr;

--
-- Name: archive; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.archive (
    name character varying NOT NULL,
    website character varying NOT NULL,
    archive_id uuid DEFAULT gen_random_uuid() NOT NULL,
    abbreviation character varying NOT NULL
);


ALTER TABLE public.archive OWNER TO regulation_usr;

--
-- Name: biosample; Type: TABLE; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.biosample OWNER TO regulation_usr;

--
-- Name: biosample_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.biosample_data_source OWNER TO regulation_usr;

--
-- Name: biosample_set; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.biosample_set (
    biosample_set_id uuid DEFAULT gen_random_uuid() NOT NULL,
    biosample_set_type public.biosample_set_type NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.biosample_set OWNER TO regulation_usr;

--
-- Name: biosample_set_biosample; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.biosample_set_biosample (
    biosample_set_id uuid NOT NULL,
    biosample_id uuid NOT NULL
);


ALTER TABLE public.biosample_set_biosample OWNER TO regulation_usr;

--
-- Name: biosample_set_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.biosample_set_data_source AS
 SELECT biosample_set.biosample_set_id,
    biosample_set.biosample_set_type,
    biosample_set.data_source_id,
    data_source.accession
   FROM (public.biosample_set
     LEFT JOIN public.data_source ON ((biosample_set.data_source_id = data_source.data_source_id)));


ALTER TABLE public.biosample_set_data_source OWNER TO regulation_usr;

--
-- Name: biosource; Type: TABLE; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.biosource OWNER TO regulation_usr;

--
-- Name: biosource_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.biosource_data_source OWNER TO regulation_usr;

--
-- Name: bucket; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.bucket (
    name text NOT NULL,
    endpoint text NOT NULL,
    bucket_id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.bucket OWNER TO regulation_usr;

--
-- Name: epigenome_group_assembly; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.epigenome_group_assembly (
    assembly_id uuid NOT NULL,
    epigenome_group_id uuid NOT NULL,
    epigenome_group_assembly_id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.epigenome_group_assembly OWNER TO regulation_usr;

--
-- Name: experiment_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.experiment_data_source OWNER TO regulation_usr;

--
-- Name: life_stage; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.life_stage (
    life_stage_id uuid DEFAULT gen_random_uuid() NOT NULL,
    term text NOT NULL,
    ontology_relation public.ontology_relation_type NOT NULL,
    ontology_id uuid NOT NULL
);


ALTER TABLE public.life_stage OWNER TO regulation_usr;

--
-- Name: ontology; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.ontology (
    ontology_id uuid DEFAULT gen_random_uuid() NOT NULL,
    ontology_type public.ontology_type NOT NULL,
    curie text NOT NULL
);


ALTER TABLE public.ontology OWNER TO regulation_usr;

--
-- Name: life_stage_with_ontology; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.life_stage_with_ontology OWNER TO regulation_usr;

--
-- Name: replicate; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.replicate (
    read_file_set_id uuid NOT NULL,
    replicate_id uuid DEFAULT gen_random_uuid() NOT NULL,
    replicate_set_id uuid NOT NULL,
    data_source_id uuid,
    biosample_set_id uuid
);


ALTER TABLE public.replicate OWNER TO regulation_usr;

--
-- Name: replicate_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.replicate_data_source OWNER TO regulation_usr;

--
-- Name: experiment_metadata; Type: VIEW; Schema: public; Owner: regulation_usr
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
    biosource_data_source.sex
   FROM (((((((((((public.species
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


ALTER TABLE public.experiment_metadata OWNER TO regulation_usr;

--
-- Name: experiment_target_info; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.experiment_target_info OWNER TO regulation_usr;

--
-- Name: read_file_set; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.read_file_set (
    read_file_set_id uuid DEFAULT gen_random_uuid() NOT NULL,
    data_source_id uuid
);


ALTER TABLE public.read_file_set OWNER TO regulation_usr;

--
-- Name: library_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.library_data_source AS
 SELECT read_file_set.read_file_set_id,
    read_file_set.data_source_id,
    data_source.accession AS library_accession
   FROM (public.read_file_set
     LEFT JOIN public.data_source ON ((read_file_set.data_source_id = data_source.data_source_id)));


ALTER TABLE public.library_data_source OWNER TO regulation_usr;

--
-- Name: mask_file; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.mask_file (
    mask_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    assembly_id uuid NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.mask_file OWNER TO regulation_usr;

--
-- Name: metadata_expr; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_expr AS
 SELECT DISTINCT experiment_metadata.species_name,
    experiment_metadata.epigenome_name,
    experiment_metadata.name,
    experiment_metadata.biosample_accession,
    initcap(replace((experiment_metadata.biomaterial_type)::text, '_'::text, ' '::text)) AS material,
    experiment_metadata.biosample_term AS term,
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
    COALESCE(experiment_metadata.replicate_set_accession, experiment_metadata.replicate_accession) AS data_source
   FROM (public.experiment_metadata
     JOIN public.analysis_file ON ((experiment_metadata.experiment_id = analysis_file.experiment_id)))
  WHERE ((analysis_file.handover = true) AND (experiment_metadata.replicate_set_type = 'signal'::text) AND (analysis_file.analysis_type = ANY (ARRAY['chip_seq_broad_peaks'::public.analysis_type, 'chip_seq_gapped_peaks'::public.analysis_type, 'chip_seq_narrow_peaks'::public.analysis_type, 'dnase_seq_peaks'::public.analysis_type, 'atac_seq_peaks'::public.analysis_type])) AND (experiment_metadata.biomaterial_type IS NOT NULL));


ALTER TABLE public.metadata_expr OWNER TO regulation_usr;

--
-- Name: metadata_expr_agg; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_expr_agg AS
 SELECT metadata_expr.species_name,
    metadata_expr.epigenome_name,
    array_agg(DISTINCT metadata_expr.name) AS experiments,
    array_agg(DISTINCT metadata_expr.biosample_accession) AS biosamples,
    metadata_expr.material,
    metadata_expr.term,
    metadata_expr.term_ontology,
    metadata_expr.organ_slims,
    metadata_expr.system_slims,
    array_agg(DISTINCT metadata_expr.experiment_type) AS experiment_types,
    array_agg(DISTINCT metadata_expr.experiment_target_type) AS experiment_target_types,
    array_agg(DISTINCT metadata_expr.experiment_target) AS experiment_targets,
    metadata_expr.sex,
    metadata_expr.life_stage,
    metadata_expr.age,
    metadata_expr.age_unit,
    array_agg(DISTINCT metadata_expr.data_source) AS data_sources
   FROM public.metadata_expr
  GROUP BY metadata_expr.species_name, metadata_expr.epigenome_name, metadata_expr.material, metadata_expr.term, metadata_expr.term_ontology, metadata_expr.organ_slims, metadata_expr.system_slims, metadata_expr.sex, metadata_expr.life_stage, metadata_expr.age, metadata_expr.age_unit;


ALTER TABLE public.metadata_expr_agg OWNER TO regulation_usr;

--
-- Name: metadata_dimension_age; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_age AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    COALESCE((min(
        CASE
            WHEN (metadata_expr_agg.age = 'unknown'::text) THEN NULL::double precision
            ELSE (metadata_expr_agg.age)::double precision
        END))::text, 'unknown'::text) AS min_value,
    COALESCE((max(
        CASE
            WHEN (metadata_expr_agg.age = 'unknown'::text) THEN NULL::double precision
            ELSE (metadata_expr_agg.age)::double precision
        END))::text, 'unknown'::text) AS max_value,
    COALESCE(metadata_expr_agg.age_unit, 'unknown'::text) AS unit
   FROM public.metadata_expr_agg
  GROUP BY metadata_expr_agg.species_name, metadata_expr_agg.age_unit
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_age OWNER TO regulation_usr;

--
-- Name: metadata_dimension_experiment_target; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_experiment_target AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    unnest(metadata_expr_agg.experiment_targets) AS name
   FROM public.metadata_expr_agg
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_experiment_target OWNER TO regulation_usr;

--
-- Name: metadata_dimension_experiment_target_type; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_experiment_target_type AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    unnest(metadata_expr_agg.experiment_target_types) AS name
   FROM public.metadata_expr_agg
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_experiment_target_type OWNER TO regulation_usr;

--
-- Name: metadata_dimension_experiment_type; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_experiment_type AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    unnest(metadata_expr_agg.experiment_types) AS name
   FROM public.metadata_expr_agg
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_experiment_type OWNER TO regulation_usr;

--
-- Name: metadata_dimension_life_stage; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_life_stage AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    metadata_expr_agg.life_stage AS name
   FROM public.metadata_expr_agg
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_life_stage OWNER TO regulation_usr;

--
-- Name: metadata_dimension_material; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_material AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    metadata_expr_agg.material AS name
   FROM public.metadata_expr_agg
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_material OWNER TO regulation_usr;

--
-- Name: metadata_dimension_organ; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_organ AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    unnest(metadata_expr_agg.organ_slims) AS name,
    array_agg(DISTINCT metadata_expr_agg.term) AS terms
   FROM public.metadata_expr_agg
  GROUP BY metadata_expr_agg.species_name, (unnest(metadata_expr_agg.organ_slims))
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_organ OWNER TO regulation_usr;

--
-- Name: metadata_dimension_sex; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_sex AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    metadata_expr_agg.sex AS name
   FROM public.metadata_expr_agg
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_sex OWNER TO regulation_usr;

--
-- Name: metadata_dimension_system; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_system AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    unnest(metadata_expr_agg.system_slims) AS name,
    array_agg(DISTINCT metadata_expr_agg.term) AS terms
   FROM public.metadata_expr_agg
  GROUP BY metadata_expr_agg.species_name, (unnest(metadata_expr_agg.system_slims))
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_system OWNER TO regulation_usr;

--
-- Name: metadata_dimension_term; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_dimension_term AS
 SELECT DISTINCT metadata_expr_agg.species_name,
    metadata_expr_agg.term AS name,
    concat('http://purl.obolibrary.org/obo/', metadata_expr_agg.term_ontology) AS ontology
   FROM public.metadata_expr_agg
  ORDER BY metadata_expr_agg.species_name;


ALTER TABLE public.metadata_dimension_term OWNER TO regulation_usr;

--
-- Name: metadata_expr_deagg; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.metadata_expr_deagg AS
 WITH organ_deagg AS (
         SELECT DISTINCT experiment_metadata_1.biosample_id,
            unnest(experiment_metadata_1.organ_slims) AS organ
           FROM public.experiment_metadata experiment_metadata_1
        ), system_deagg AS (
         SELECT DISTINCT experiment_metadata_1.biosample_id,
            unnest(experiment_metadata_1.system_slims) AS system
           FROM public.experiment_metadata experiment_metadata_1
        )
 SELECT DISTINCT experiment_metadata.species_name,
    experiment_metadata.epigenome_name AS name,
    experiment_metadata.name AS experiment_name,
    experiment_metadata.biosample_accession,
    initcap(replace((experiment_metadata.biomaterial_type)::text, '_'::text, ' '::text)) AS material,
    experiment_metadata.biosample_term AS term,
    concat(experiment_metadata.ontology_type, '_', experiment_metadata.curie) AS term_ontology,
    experiment_metadata.organ_slims,
    organ_deagg.organ,
    experiment_metadata.system_slims,
    system_deagg.system,
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
    COALESCE(experiment_metadata.replicate_set_accession, experiment_metadata.replicate_accession) AS data_source
   FROM (((public.experiment_metadata
     JOIN public.analysis_file ON ((experiment_metadata.experiment_id = analysis_file.experiment_id)))
     LEFT JOIN organ_deagg ON ((organ_deagg.biosample_id = experiment_metadata.biosample_id)))
     LEFT JOIN system_deagg ON ((system_deagg.biosample_id = experiment_metadata.biosample_id)))
  WHERE ((analysis_file.handover = true) AND (experiment_metadata.replicate_set_type = 'signal'::text) AND (analysis_file.analysis_type = ANY (ARRAY['chip_seq_broad_peaks'::public.analysis_type, 'chip_seq_gapped_peaks'::public.analysis_type, 'chip_seq_narrow_peaks'::public.analysis_type, 'dnase_seq_peaks'::public.analysis_type, 'atac_seq_peaks'::public.analysis_type])) AND (experiment_metadata.biomaterial_type IS NOT NULL));


ALTER TABLE public.metadata_expr_deagg OWNER TO regulation_usr;

--
-- Name: posix_file; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.posix_file (
    posix_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    path text NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.posix_file OWNER TO regulation_usr;

--
-- Name: public_url; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.public_url (
    public_url_id uuid DEFAULT gen_random_uuid() NOT NULL,
    url text NOT NULL,
    file_id uuid NOT NULL
);


ALTER TABLE public.public_url OWNER TO regulation_usr;

--
-- Name: quality_annotation; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.quality_annotation (
    quality_annotation_id uuid DEFAULT gen_random_uuid() NOT NULL,
    accession text NOT NULL,
    date date,
    note text NOT NULL,
    quality_annotation_type public.quality_annotation_type NOT NULL
);


ALTER TABLE public.quality_annotation OWNER TO regulation_usr;

--
-- Name: read_file; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.read_file (
    split_order integer NOT NULL,
    technical_replicate integer NOT NULL,
    read_file_id uuid DEFAULT gen_random_uuid() NOT NULL,
    read_file_set_id uuid NOT NULL,
    file_id uuid NOT NULL,
    read_count integer,
    base_count bigint,
    paired_order integer NOT NULL,
    run_order public.run_order_type,
    run_id uuid,
    data_source_id uuid
);


ALTER TABLE public.read_file OWNER TO regulation_usr;

--
-- Name: read_file_data_source; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.read_file_data_source OWNER TO regulation_usr;

--
-- Name: run; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.run (
    run_id uuid DEFAULT gen_random_uuid() NOT NULL,
    run_type public.run_type NOT NULL,
    read_length integer NOT NULL,
    read_file_set_id uuid,
    data_source_id uuid,
    read_count integer NOT NULL,
    technical_replicate integer NOT NULL
);


ALTER TABLE public.run OWNER TO regulation_usr;

--
-- Name: read_file_metadata; Type: VIEW; Schema: public; Owner: regulation_usr
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
    run.technical_replicate,
    run.run_type,
    run.read_length,
    run.read_count,
    run.run_id,
    read_file_data_source.run_order,
    read_file_data_source.read_file_accession,
    read_file_data_source.read_file_id,
    file.file_id,
    file.size,
    file.md5sum,
    public_url.url
   FROM ((((((public.experiment_metadata
     JOIN public.replicate ON (((experiment_metadata.replicate_id = replicate.replicate_id) AND (replicate.biosample_set_id = experiment_metadata.biosample_set_id))))
     JOIN public.library_data_source ON ((replicate.read_file_set_id = library_data_source.read_file_set_id)))
     JOIN public.run ON ((library_data_source.read_file_set_id = run.read_file_set_id)))
     JOIN public.read_file_data_source ON ((run.run_id = read_file_data_source.run_id)))
     JOIN public.file ON ((read_file_data_source.file_id = file.file_id)))
     JOIN public.public_url ON ((file.file_id = public_url.file_id)));


ALTER TABLE public.read_file_metadata OWNER TO regulation_usr;

--
-- Name: run_accession; Type: VIEW; Schema: public; Owner: regulation_usr
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


ALTER TABLE public.run_accession OWNER TO regulation_usr;

--
-- Name: run_alignment_task; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.run_alignment_task (
    run_id uuid NOT NULL,
    alignment_task_id uuid NOT NULL
);


ALTER TABLE public.run_alignment_task OWNER TO regulation_usr;

--
-- Name: subsite_data_sources; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.subsite_data_sources AS
 SELECT DISTINCT experiment_metadata.species_name,
    experiment_metadata.name,
    experiment_metadata.biosample_accession,
    initcap(replace((experiment_metadata.biomaterial_type)::text, '_'::text, ' '::text)) AS material,
    experiment_metadata.biosample_term AS term,
    concat(experiment_metadata.ontology_type, '_', experiment_metadata.curie) AS term_ontology,
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
            ELSE NULL::text
        END AS age,
        CASE
            WHEN (experiment_metadata.thermal_time IS NOT NULL) THEN 'thermal time'::text
            ELSE (COALESCE(experiment_metadata.age_at_collection_unit, experiment_metadata.age_unit))::text
        END AS age_unit,
    COALESCE(experiment_metadata.replicate_set_accession, experiment_metadata.replicate_accession) AS data_source
   FROM (public.experiment_metadata
     JOIN public.analysis_file ON ((experiment_metadata.experiment_id = analysis_file.experiment_id)))
  WHERE ((analysis_file.handover = true) AND ((experiment_metadata.experiment_target_type <> 'tf'::text) OR (experiment_metadata.experiment_target = 'CTCF'::text)) AND (experiment_metadata.replicate_set_type = 'signal'::text) AND (analysis_file.analysis_type = ANY (ARRAY['chip_seq_broad_peaks'::public.analysis_type, 'chip_seq_gapped_peaks'::public.analysis_type, 'chip_seq_narrow_peaks'::public.analysis_type, 'dnase_seq_peaks'::public.analysis_type, 'atac_seq_peaks'::public.analysis_type])) AND (experiment_metadata.biomaterial_type IS NOT NULL));


ALTER TABLE public.subsite_data_sources OWNER TO regulation_usr;

--
-- Name: subsite_data_sources_agg_by_expr; Type: VIEW; Schema: public; Owner: regulation_usr
--

CREATE VIEW public.subsite_data_sources_agg_by_expr AS
 SELECT subsite_data_sources.species_name,
    subsite_data_sources.name,
    array_agg(subsite_data_sources.biosample_accession) AS biosamples,
    subsite_data_sources.material,
    subsite_data_sources.term,
    subsite_data_sources.term_ontology,
    subsite_data_sources.experiment_type,
    subsite_data_sources.experiment_target_type,
    subsite_data_sources.sex,
    subsite_data_sources.life_stage,
    subsite_data_sources.age,
    subsite_data_sources.age_unit,
    array_agg(DISTINCT subsite_data_sources.data_source) AS data_sources
   FROM public.subsite_data_sources
  GROUP BY subsite_data_sources.species_name, subsite_data_sources.name, subsite_data_sources.material, subsite_data_sources.term, subsite_data_sources.term_ontology, subsite_data_sources.experiment_type, subsite_data_sources.experiment_target_type, subsite_data_sources.sex, subsite_data_sources.life_stage, subsite_data_sources.age, subsite_data_sources.age_unit;


ALTER TABLE public.subsite_data_sources_agg_by_expr OWNER TO regulation_usr;

--
-- Name: track; Type: TABLE; Schema: public; Owner: regulation_usr
--

CREATE TABLE public.track (
    metadata jsonb,
    epigenome_id uuid,
    track_id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.track OWNER TO regulation_usr;

--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: alignment_file alignment_file_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_pkey PRIMARY KEY (alignment_file_id);


--
-- Name: alignment_task alignment_task_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.alignment_task
    ADD CONSTRAINT alignment_task_pkey PRIMARY KEY (alignment_task_id);


--
-- Name: analysis_file analysis_file_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT analysis_file_pkey PRIMARY KEY (analysis_file_id);


--
-- Name: archive archive_abbreviation_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_abbreviation_key UNIQUE (abbreviation);


--
-- Name: archive archive_name_website_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_name_website_key UNIQUE (name, website);


--
-- Name: archive archive_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.archive
    ADD CONSTRAINT archive_pkey PRIMARY KEY (archive_id);


--
-- Name: assembly assembly_ensembl_accession_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.assembly
    ADD CONSTRAINT assembly_ensembl_accession_key UNIQUE (ensembl_accession);


--
-- Name: assembly assembly_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.assembly
    ADD CONSTRAINT assembly_pkey PRIMARY KEY (assembly_id);


--
-- Name: atac_seq atac_seq_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.atac_seq
    ADD CONSTRAINT atac_seq_pkey PRIMARY KEY (experiment_id);


--
-- Name: biosample biosample_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_pkey PRIMARY KEY (biosample_id);


--
-- Name: biosample_set_biosample biosample_set_biosample_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample_set_biosample
    ADD CONSTRAINT biosample_set_biosample_pkey PRIMARY KEY (biosample_set_id, biosample_id);


--
-- Name: biosample_set biosample_set_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample_set
    ADD CONSTRAINT biosample_set_pkey PRIMARY KEY (biosample_set_id);


--
-- Name: biosource biosource_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosource
    ADD CONSTRAINT biosource_pkey PRIMARY KEY (biosource_id);


--
-- Name: bucket bucket_name_endpoint_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.bucket
    ADD CONSTRAINT bucket_name_endpoint_key UNIQUE (name, endpoint);


--
-- Name: bucket bucket_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.bucket
    ADD CONSTRAINT bucket_pkey PRIMARY KEY (bucket_id);


--
-- Name: chip_seq chip_seq_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_pkey PRIMARY KEY (experiment_id);


--
-- Name: data_source data_source_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.data_source
    ADD CONSTRAINT data_source_pkey PRIMARY KEY (data_source_id);


--
-- Name: dnase_seq dnase_seq_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.dnase_seq
    ADD CONSTRAINT dnase_seq_pkey PRIMARY KEY (experiment_id);


--
-- Name: epigenome_group_assembly epigenome_group_assembly_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome_group_assembly
    ADD CONSTRAINT epigenome_group_assembly_pkey PRIMARY KEY (epigenome_group_assembly_id);


--
-- Name: epigenome_group epigenome_group_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome_group
    ADD CONSTRAINT epigenome_group_pkey PRIMARY KEY (epigenome_group_id);


--
-- Name: epigenome epigenome_name_species_id_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_name_species_id_key UNIQUE (name, species_id);


--
-- Name: epigenome epigenome_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_pkey PRIMARY KEY (epigenome_id);


--
-- Name: experiment experiment_name_epigenome_id_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.experiment
    ADD CONSTRAINT experiment_name_epigenome_id_key UNIQUE (name, epigenome_id);


--
-- Name: experiment experiment_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.experiment
    ADD CONSTRAINT experiment_pkey PRIMARY KEY (experiment_id);


--
-- Name: file file_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (file_id);


--
-- Name: histone_target histone_target_name_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.histone_target
    ADD CONSTRAINT histone_target_name_key UNIQUE (name);


--
-- Name: histone_target histone_target_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.histone_target
    ADD CONSTRAINT histone_target_pkey PRIMARY KEY (histone_target_id);


--
-- Name: life_stage life_stage_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.life_stage
    ADD CONSTRAINT life_stage_pkey PRIMARY KEY (life_stage_id);


--
-- Name: life_stage life_stage_term_ontology_relation_ontology_id_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.life_stage
    ADD CONSTRAINT life_stage_term_ontology_relation_ontology_id_key UNIQUE (term, ontology_id, ontology_relation);


--
-- Name: mask_file mask_file_assembly_id_file_id_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.mask_file
    ADD CONSTRAINT mask_file_assembly_id_file_id_key UNIQUE (assembly_id, file_id);


--
-- Name: mask_file mask_file_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.mask_file
    ADD CONSTRAINT mask_file_pkey PRIMARY KEY (mask_file_id);


--
-- Name: ontology ontology_ontology_type_curie_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.ontology
    ADD CONSTRAINT ontology_ontology_type_curie_key UNIQUE (ontology_type, curie);


--
-- Name: ontology ontology_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.ontology
    ADD CONSTRAINT ontology_pkey PRIMARY KEY (ontology_id);


--
-- Name: posix_file posix_file_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.posix_file
    ADD CONSTRAINT posix_file_pkey PRIMARY KEY (posix_file_id);


--
-- Name: public_url public_url_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.public_url
    ADD CONSTRAINT public_url_pkey PRIMARY KEY (public_url_id);


--
-- Name: quality_annotation quality_annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.quality_annotation
    ADD CONSTRAINT quality_annotation_pkey PRIMARY KEY (quality_annotation_id);


--
-- Name: read_file read_file_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_pkey PRIMARY KEY (read_file_id);


--
-- Name: read_file_set read_file_set_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.read_file_set
    ADD CONSTRAINT read_file_set_pkey PRIMARY KEY (read_file_set_id);


--
-- Name: replicate replicate_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_pkey PRIMARY KEY (replicate_id);


--
-- Name: replicate_set replicate_set_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.replicate_set
    ADD CONSTRAINT replicate_set_pkey PRIMARY KEY (replicate_set_id);


--
-- Name: run_alignment_task run_alignment_task_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.run_alignment_task
    ADD CONSTRAINT run_alignment_task_pkey PRIMARY KEY (run_id, alignment_task_id);


--
-- Name: run run_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_pkey PRIMARY KEY (run_id);


--
-- Name: s3_object s3_object_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.s3_object
    ADD CONSTRAINT s3_object_pkey PRIMARY KEY (s3_object_id);


--
-- Name: species species_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_pkey PRIMARY KEY (species_id);


--
-- Name: tf_target tf_target_name_gene_stable_id_key; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.tf_target
    ADD CONSTRAINT tf_target_name_gene_stable_id_key UNIQUE (name, gene_stable_id);


--
-- Name: tf_target tf_target_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.tf_target
    ADD CONSTRAINT tf_target_pkey PRIMARY KEY (tf_target_id);


--
-- Name: track track_pkey; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_pkey PRIMARY KEY (track_id);


--
-- Name: alignment_file uq_alignment_file_assembly_id_read_file_set_id_file_id; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT uq_alignment_file_assembly_id_read_file_set_id_file_id UNIQUE (assembly_id, read_file_set_id, file_id);


--
-- Name: analysis_file uq_analysis_file_assembly_id_experiment_id_analysis_type; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT uq_analysis_file_assembly_id_experiment_id_analysis_type UNIQUE (assembly_id, experiment_id, analysis_type);


--
-- Name: atac_seq uq_atac_seq_replicate_set_id; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.atac_seq
    ADD CONSTRAINT uq_atac_seq_replicate_set_id UNIQUE (replicate_set_id);


--
-- Name: chip_seq uq_chip_seq_signal; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT uq_chip_seq_signal UNIQUE (signal);


--
-- Name: dnase_seq uq_dnase_seq_replicate_set_id; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.dnase_seq
    ADD CONSTRAINT uq_dnase_seq_replicate_set_id UNIQUE (replicate_set_id);


--
-- Name: run uq_run_read_file_set_id_technical_replicate; Type: CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT uq_run_read_file_set_id_technical_replicate UNIQUE (read_file_set_id, technical_replicate);


--
-- Name: ix_assembly_species_id; Type: INDEX; Schema: public; Owner: regulation_usr
--

CREATE INDEX ix_assembly_species_id ON public.assembly USING btree (species_id);


--
-- Name: ix_data_source_accession; Type: INDEX; Schema: public; Owner: regulation_usr
--

CREATE INDEX ix_data_source_accession ON public.data_source USING btree (accession);


--
-- Name: ix_epigenome_group_assembly_assembly_id; Type: INDEX; Schema: public; Owner: regulation_usr
--

CREATE INDEX ix_epigenome_group_assembly_assembly_id ON public.epigenome_group_assembly USING btree (assembly_id);


--
-- Name: ix_epigenome_group_assembly_epigenome_group_id; Type: INDEX; Schema: public; Owner: regulation_usr
--

CREATE INDEX ix_epigenome_group_assembly_epigenome_group_id ON public.epigenome_group_assembly USING btree (epigenome_group_id);


--
-- Name: ix_mask_file_assembly_id; Type: INDEX; Schema: public; Owner: regulation_usr
--

CREATE INDEX ix_mask_file_assembly_id ON public.mask_file USING btree (assembly_id);


--
-- Name: ix_quality_annotation_accession; Type: INDEX; Schema: public; Owner: regulation_usr
--

CREATE INDEX ix_quality_annotation_accession ON public.quality_annotation USING btree (accession);


--
-- Name: alignment_file alignment_file_alignment_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_alignment_task_id_fkey FOREIGN KEY (alignment_task_id) REFERENCES public.alignment_task(alignment_task_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: alignment_file alignment_file_assembly_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_assembly_id_fkey FOREIGN KEY (assembly_id) REFERENCES public.assembly(assembly_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: alignment_file alignment_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: alignment_file alignment_file_read_file_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.alignment_file
    ADD CONSTRAINT alignment_file_read_file_set_id_fkey FOREIGN KEY (read_file_set_id) REFERENCES public.read_file_set(read_file_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: analysis_file analysis_file_assembly_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT analysis_file_assembly_id_fkey FOREIGN KEY (assembly_id) REFERENCES public.assembly(assembly_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: analysis_file analysis_file_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT analysis_file_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: analysis_file analysis_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.analysis_file
    ADD CONSTRAINT analysis_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: assembly assembly_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.assembly
    ADD CONSTRAINT assembly_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: assembly assembly_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.assembly
    ADD CONSTRAINT assembly_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(species_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: atac_seq atac_seq_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.atac_seq
    ADD CONSTRAINT atac_seq_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: atac_seq atac_seq_replicate_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.atac_seq
    ADD CONSTRAINT atac_seq_replicate_set_id_fkey FOREIGN KEY (replicate_set_id) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_alternative_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_alternative_data_source_id_fkey FOREIGN KEY (alternative_data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_biosource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_biosource_id_fkey FOREIGN KEY (biosource_id) REFERENCES public.biosource(biosource_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_life_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_life_stage_id_fkey FOREIGN KEY (life_stage_id) REFERENCES public.life_stage(life_stage_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample biosample_ontology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample
    ADD CONSTRAINT biosample_ontology_id_fkey FOREIGN KEY (ontology_id) REFERENCES public.ontology(ontology_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample_set_biosample biosample_set_biosample_biosample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample_set_biosample
    ADD CONSTRAINT biosample_set_biosample_biosample_id_fkey FOREIGN KEY (biosample_id) REFERENCES public.biosample(biosample_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample_set_biosample biosample_set_biosample_biosample_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample_set_biosample
    ADD CONSTRAINT biosample_set_biosample_biosample_set_id_fkey FOREIGN KEY (biosample_set_id) REFERENCES public.biosample_set(biosample_set_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosample_set biosample_set_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosample_set
    ADD CONSTRAINT biosample_set_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosource biosource_alternative_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosource
    ADD CONSTRAINT biosource_alternative_data_source_id_fkey FOREIGN KEY (alternative_data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosource biosource_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosource
    ADD CONSTRAINT biosource_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: biosource biosource_life_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.biosource
    ADD CONSTRAINT biosource_life_stage_id_fkey FOREIGN KEY (life_stage_id) REFERENCES public.life_stage(life_stage_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_control_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_control_fkey FOREIGN KEY (control) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_histone_target_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_histone_target_id_fkey FOREIGN KEY (histone_target_id) REFERENCES public.histone_target(histone_target_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_signal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_signal_fkey FOREIGN KEY (signal) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: chip_seq chip_seq_tf_target_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.chip_seq
    ADD CONSTRAINT chip_seq_tf_target_id_fkey FOREIGN KEY (tf_target_id) REFERENCES public.tf_target(tf_target_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: data_source data_source_archive_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.data_source
    ADD CONSTRAINT data_source_archive_id_fkey FOREIGN KEY (archive_id) REFERENCES public.archive(archive_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: dnase_seq dnase_seq_experiment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.dnase_seq
    ADD CONSTRAINT dnase_seq_experiment_id_fkey FOREIGN KEY (experiment_id) REFERENCES public.experiment(experiment_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: dnase_seq dnase_seq_replicate_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.dnase_seq
    ADD CONSTRAINT dnase_seq_replicate_set_id_fkey FOREIGN KEY (replicate_set_id) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome epigenome_alternative_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_alternative_data_source_id_fkey FOREIGN KEY (alternative_data_source_id) REFERENCES public.data_source(data_source_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome epigenome_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome epigenome_epigenome_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_epigenome_group_id_fkey FOREIGN KEY (epigenome_group_id) REFERENCES public.epigenome_group(epigenome_group_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome_group_assembly epigenome_group_assembly_assembly_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome_group_assembly
    ADD CONSTRAINT epigenome_group_assembly_assembly_id_fkey FOREIGN KEY (assembly_id) REFERENCES public.assembly(assembly_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome_group_assembly epigenome_group_assembly_epigenome_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome_group_assembly
    ADD CONSTRAINT epigenome_group_assembly_epigenome_group_id_fkey FOREIGN KEY (epigenome_group_id) REFERENCES public.epigenome_group(epigenome_group_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome_group epigenome_group_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome_group
    ADD CONSTRAINT epigenome_group_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: epigenome epigenome_species_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.epigenome
    ADD CONSTRAINT epigenome_species_id_fkey FOREIGN KEY (species_id) REFERENCES public.species(species_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: experiment experiment_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.experiment
    ADD CONSTRAINT experiment_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: experiment experiment_epigenome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.experiment
    ADD CONSTRAINT experiment_epigenome_id_fkey FOREIGN KEY (epigenome_id) REFERENCES public.epigenome(epigenome_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: file file_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: life_stage life_stage_ontology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.life_stage
    ADD CONSTRAINT life_stage_ontology_id_fkey FOREIGN KEY (ontology_id) REFERENCES public.ontology(ontology_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: mask_file mask_file_assembly_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.mask_file
    ADD CONSTRAINT mask_file_assembly_id_fkey FOREIGN KEY (assembly_id) REFERENCES public.assembly(assembly_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: mask_file mask_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.mask_file
    ADD CONSTRAINT mask_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: posix_file posix_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.posix_file
    ADD CONSTRAINT posix_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: public_url public_url_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.public_url
    ADD CONSTRAINT public_url_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file read_file_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file read_file_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file read_file_read_file_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_read_file_set_id_fkey FOREIGN KEY (read_file_set_id) REFERENCES public.read_file_set(read_file_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file read_file_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.read_file
    ADD CONSTRAINT read_file_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.run(run_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: read_file_set read_file_set_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.read_file_set
    ADD CONSTRAINT read_file_set_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate replicate_biosample_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_biosample_set_id_fkey FOREIGN KEY (biosample_set_id) REFERENCES public.biosample_set(biosample_set_id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate replicate_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate replicate_read_file_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_read_file_set_id_fkey FOREIGN KEY (read_file_set_id) REFERENCES public.read_file_set(read_file_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate replicate_replicate_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.replicate
    ADD CONSTRAINT replicate_replicate_set_id_fkey FOREIGN KEY (replicate_set_id) REFERENCES public.replicate_set(replicate_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: replicate_set replicate_set_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.replicate_set
    ADD CONSTRAINT replicate_set_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: run_alignment_task run_alignment_task_alignment_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.run_alignment_task
    ADD CONSTRAINT run_alignment_task_alignment_task_id_fkey FOREIGN KEY (alignment_task_id) REFERENCES public.alignment_task(alignment_task_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: run_alignment_task run_alignment_task_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.run_alignment_task
    ADD CONSTRAINT run_alignment_task_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.run(run_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: run run_data_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_data_source_id_fkey FOREIGN KEY (data_source_id) REFERENCES public.data_source(data_source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: run run_read_file_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.run
    ADD CONSTRAINT run_read_file_set_id_fkey FOREIGN KEY (read_file_set_id) REFERENCES public.read_file_set(read_file_set_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: s3_object s3_object_bucket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.s3_object
    ADD CONSTRAINT s3_object_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES public.bucket(bucket_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: s3_object s3_object_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.s3_object
    ADD CONSTRAINT s3_object_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file(file_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: track track_epigenome_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: regulation_usr
--

ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_epigenome_id_fkey FOREIGN KEY (epigenome_id) REFERENCES public.epigenome(epigenome_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

