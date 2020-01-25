#! /bin/bash

#cwl-runner --outdir FASTQ_Trimmed sickle_trim.cwl trim_ent256.yml
#cwl-runner --outdir Genome download.cwl b73_download.yml
cwl-runner --outdir Genome gunzip.cwl b73_gunzip.yml
