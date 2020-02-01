#! /bin/bash

#cwl-runner --outdir Genome prep_gzipped_fasta.cwl b73_fasta.yml
#cwl-runner --outdir Genome bowtie2_build.cwl b73_bowtie2-build.yml

##cwl-runner --outdir FASTQ_Trimmed sickle_trim.cwl trim_test.yml
#cwl-runner --outdir FASTQ_Trimmed sickle_trim.cwl trim_ent256.yml

##cwl-runner --outdir BAM bowtie2_align.cwl bowtie2_test.yml
cwl-runner --outdir BAM bowtie2_align.cwl bowtie2_ent256.yml

#cwl-runner --outdir Pileups mpileup.cwl mpileup_test.yml
cwl-runner --outdir Pileups mpileup.cwl mpileup_ent256.yml
