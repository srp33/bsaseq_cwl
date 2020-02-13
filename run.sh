#! /bin/bash

set -o errexit

SETTINGS="--tmpdir-prefix /Applications/tmp/cwl-runner_tmp --tmp-outdir-prefix /Applications/tmp/cwl-runner_tmpoutdir"
#  --cachedir CACHEDIR   Directory to cache intermediate workflow outputs to avoid recomputing steps.

#cwl-runner --outdir Genome $SETTINGS prep_gzipped_fasta.cwl b73_fasta.yml
#cwl-runner --outdir Ref_VCF $SETTINGS prep_reference_vcf.cwl zea_mays_reference_variants.yml
#cwl-runner --outdir Genome $SETTINGS bowtie2_build.cwl b73_bowtie2-build.yml

##cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_test.yml
#cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_ent256.yml &
#cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_ent461.yml &
#cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_ent40.yml &
#cwl-runner --outdir FASTQ_Trimmed $SETTINGS sickle_trim.cwl trim_a619.yml &
#wait

##cwl-runner --outdir BAM $SETTINGS bowtie2_align.cwl bowtie2_test.yml
#cwl-runner --outdir BAM $SETTINGS bowtie2_align.cwl bowtie2_ent256.yml &
#cwl-runner --outdir BAM $SETTINGS bowtie2_align.cwl bowtie2_ent461.yml &
#cwl-runner --outdir BAM $SETTINGS bowtie2_align.cwl bowtie2_ent40.yml &
#cwl-runner --outdir BAM $SETTINGS bowtie2_align.cwl bowtie2_a619.yml &
#wait

#cwl-runner --outdir Pileups $SETTINGS mpileup.cwl mpileup_test.yml
#cwl-runner --outdir Pileups $SETTINGS mpileup.cwl mpileup_ent256.yml &
#cwl-runner --outdir Pileups $SETTINGS mpileup.cwl mpileup_ent461.yml &
#cwl-runner --outdir Pileups $SETTINGS mpileup.cwl mpileup_ent40.yml &
#cwl-runner --outdir Pileups $SETTINGS mpileup.cwl mpileup_a619.yml &
#wait

#cwl-runner --outdir Pileups_TSV $SETTINGS parse_pileup.cwl parse_pileup_test.yml
#cwl-runner --outdir Pileups_TSV $SETTINGS parse_pileup.cwl parse_pileup_ent256.yml &
#cwl-runner --outdir Pileups_TSV $SETTINGS parse_pileup.cwl parse_pileup_ent461.yml &
#cwl-runner --outdir Pileups_TSV $SETTINGS parse_pileup.cwl parse_pileup_ent40.yml &
#cwl-runner --outdir Pileups_TSV $SETTINGS parse_pileup.cwl parse_pileup_a619.yml &
#wait

#cwl-runner --outdir Pileups_TSV_Filtered $SETTINGS filter_pileup.cwl filter_pileup_test.yml
#cwl-runner --outdir Pileups_TSV_Filtered $SETTINGS filter_pileup.cwl filter_pileup_ent256.yml &
#cwl-runner --outdir Pileups_TSV_Filtered $SETTINGS filter_pileup.cwl filter_pileup_ent461.yml &
#cwl-runner --outdir Pileups_TSV_Filtered $SETTINGS filter_pileup.cwl filter_pileup_a619.yml &
#wait

#cwl-runner --outdir VCF $SETTINGS varscan_call_variants.cwl varscan_call_variants_test.yml
#cwl-runner --outdir VCF $SETTINGS varscan_call_variants.cwl varscan_call_variants_ent256.yml &
#cwl-runner --outdir VCF $SETTINGS varscan_call_variants.cwl varscan_call_variants_ent461.yml &
#cwl-runner --outdir VCF $SETTINGS varscan_call_variants.cwl varscan_call_variants_ent40.yml &
#cwl-runner --outdir VCF $SETTINGS varscan_call_variants.cwl varscan_call_variants_a619.yml &
#wait

#cwl-runner --outdir VCF_Subtracted $SETTINGS subtract_variants.cwl subtract_variants_ent256.yml &
#cwl-runner --outdir VCF_Subtracted $SETTINGS subtract_variants.cwl subtract_variants_ent461.yml &
#cwl-runner --outdir VCF_Subtracted $SETTINGS subtract_variants.cwl subtract_variants_ent40.yml &
#wait

cwl-runner --outdir VCF_Annotated $SETTINGS annotate_variants.cwl annotate_variants_ent256.yml
#cwl-runner --outdir VCF_Annotated $SETTINGS annotate_variants.cwl annotate_variants_ent256.yml &
#cwl-runner --outdir VCF_Annotated $SETTINGS annotate_variants.cwl annotate_variants_ent461.yml &
#cwl-runner --outdir VCF_Annotated $SETTINGS annotate_variants.cwl annotate_variants_ent40.yml &
wait
