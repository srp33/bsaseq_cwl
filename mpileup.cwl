#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: mpileup
    dockerFile: |-
      FROM biocontainers/biocontainers:v1.0.0_cv4
      RUN conda install -c bioconda samtools -y
  ShellCommandRequirement: {}
arguments:
    - shellQuote: false
      valueFrom: >
        samtools mpileup
        -f $(inputs.fasta_dir.path)/$(inputs.fasta_prefix)$(inputs.fasta_file_extension)
        -o $(inputs.out_file_name)
        $(inputs.bam_file.path)
inputs:
  fasta_dir:
    type: Directory
  fasta_prefix:
    type: string
  fasta_file_extension:
    type: string
  bam_file:
    type: File
  out_file_name:
    type: string
outputs:
  example_out:
    type: stdout
  out_files:
    type:
      type: array
      items: File
    outputBinding:
      glob: "$(inputs.out_file_name)"
stdout: output.txt
