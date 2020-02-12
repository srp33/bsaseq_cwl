#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerImageId: prep_reference_vcf
    dockerFile: |-
      FROM biocontainers/biocontainers:v1.0.0_cv4
  ShellCommandRequirement: {}
inputs:
  file_url:
    type: string
  out_file_name:
    type: string
outputs:
  out_files:
    type: File
    outputBinding:
      glob: "$(inputs.out_file_name)"
arguments:
    - shellQuote: false
      valueFrom: >
        FILE_NAME=`basename $(inputs.file_url)`

        wget $(inputs.file_url)

        gunzip -c \${FILE_NAME} > $(runtime.outdir)/$(inputs.out_file_name)
