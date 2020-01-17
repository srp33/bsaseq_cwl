#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: sickle
arguments: ["-s", "/dev/null", "-t", "sanger", "-g"]
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sickle-trim:1.33--2
inputs:
  in_fastq_file_1:
    type: File
    inputBinding:
      prefix: -f
      separate: false
      position: 1
  in_fastq_file_2:
    type: File
    inputBinding:
      prefix: -r
      separate: false
      position: 2
  out_fastq_file_1:
    type: File
    inputBinding:
      prefix: -o
      separate: false
      position: 3
  out_fastq_file_2:
    type: File
    inputBinding:
      prefix: -p
      separate: false
      position: 4
outputs:
  example_out:
    type: stdout
stdout: output.txt
