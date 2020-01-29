#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: bowtie2-build
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bowtie2:2.3.5--py37he860b03_0
inputs:
  threads:
    type: int
    inputBinding:
      prefix: --threads
      position: 1
  fasta_file:
    type: File
    inputBinding:
      prefix: -f
      separate: true
      position: 2
  base_name:
    type: string
    inputBinding:
      position: 3
outputs:
  example_out:
    type: stdout
  out_file:
    type:
      type: array
      items: File
    outputBinding:
      glob: "B73*"
stdout: output.txt
