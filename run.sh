#! /bin/bash

set -o errexit

SETTINGS="--tmpdir-prefix /Applications/tmp/cwl-runner_tmp --tmp-outdir-prefix /Applications/tmp/cwl-runner_tmpoutdir"
#  --cachedir CACHEDIR   Directory to cache intermediate workflow outputs to avoid recomputing steps.

#cwl-runner --outdir Genome $SETTINGS prep_gzipped_fasta.cwl b73_fasta.yml
#cwl-runner --outdir Genome $SETTINGS bowtie2_build.cwl b73_bowtie2-build.yml

##cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_test.yml
#cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_ent256.yml
cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_ent461.yml &
cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_ent40.yml &
wait

##cwl-runner --outdir BAM $SETTINGS bowtie2_align.cwl bowtie2_test.yml
#cwl-runner --outdir BAM $SETTINGS bowtie2_align.cwl bowtie2_ent256.yml

##cwl-runner --outdir Pileups $SETTINGS mpileup.cwl mpileup_test.yml
#cwl-runner --outdir Pileups $SETTINGS mpileup.cwl mpileup_ent256.yml
