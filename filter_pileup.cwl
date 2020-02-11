#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: filter_pileup
    dockerFile: |-
      FROM biocontainers/biocontainers:v1.0.0_cv4
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
arguments:
    - shellQuote: false
      valueFrom: >
        mawk '{ if ($3!="N") { print } }' "$(inputs.in_file.path)"
        |
        mawk '{ if ( $11 >= 4) { print } }'
        |
        mawk 'BEGIN {OFS="\\t"} { $13 = ($12 / $11); print }'
        > "$(runtime.outdir)/$(inputs.out_file_name)"
inputs:
  in_file:
    type: File
  out_file_name:
    type: string
outputs:
  out_files:
    type: File
    outputBinding:
      glob: "$(inputs.out_file_name)"
