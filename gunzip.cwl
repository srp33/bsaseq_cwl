#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: gunzip
requirements:
- class: DockerRequirement
  dockerPull: phusion/baseimage:master-amd64
inputs:
  gzipped_file:
    type: File
    inputBinding:
      prefix: -c
      position: 1
  out_file:
    type: string
outputs:
  out_file_output:
    type: stdout
stdout: $(inputs.out_file)
