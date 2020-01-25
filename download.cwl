#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: wget
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/gnu-wget:1.18--3
inputs:
  file_url:
    type: string
    inputBinding:
      position: 2
  out_file:
    type: string
    inputBinding:
      prefix: -O 
      position: 1
outputs:
  out_file_output:
    type: File
    outputBinding:
      glob: $(inputs.out_file)
