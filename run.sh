#! /bin/bash

#cwl-runner --outdir FASTQ_Trimmed sickle_trim.cwl trim_ent256.yml
#cwl-runner --outdir Genome prep_gzipped_fasta.cwl b73_fasta.yml
cwl-runner --outdir Genome bowtie2-build.cwl b73_bowtie2-build.yml
