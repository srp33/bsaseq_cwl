#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: annotate_variants
    dockerFile: |-
      FROM quay.io/biocontainers/snpeff:4.3--2

      RUN snpEff download Zea_mays
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
inputs:
  vcf_file:
    type: File
  out_file_name:
    type: string
outputs:
  example_out:
    type: stdout
  out_files:
    type: File
    outputBinding:
      glob: "$(inputs.out_file_name)"
stdout: output.txt
arguments:
    - shellQuote: false
      valueFrom: >
        snpEff -Xmx4g Zea_mays $(inputs.vcf_file.path)
        > $(runtime.outdir)/$(inputs.out_file_name)
