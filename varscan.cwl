#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: java -jar VarScan.jar mpileup2cns "${CHR_TSV_FILE}" --min-coverage 4 --min-var-freq 0.5 --p-value 0.99
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/varscan:2.3.7--2
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
