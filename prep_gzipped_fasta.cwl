#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["bash", "go.sh"]
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerImageId: prep_gzipped_fasta
    dockerFile: |-
      FROM biocontainers/biocontainers:v1.0.0_cv4
      RUN conda install -c bioconda samtools -y
  InitialWorkDirRequirement:
    listing:
    - entryname: go.sh
      entry: |-
        LOCAL_FILE=$TMPDIR/`basename $(inputs.file_url)`

        wget -O $LOCAL_FILE $(inputs.file_url)
        gunzip -c $LOCAL_FILE > $(runtime.outdir)/$(inputs.out_file_name)
        samtools faidx $(runtime.outdir)/$(inputs.out_file_name)
inputs:
  file_url:
    type: string
    inputBinding:
      position: 1
  out_file_name:
    type: string
outputs:
  out_files:
    type:
      type: array
      items: File
    outputBinding:
      glob: "$(inputs.out_file_name)*"
