#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["sickle", "pe", "-s", "/dev/null", "-t", "sanger", "-g"]
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sickle-trim:1.33--2
inputs:
  in_file_1:
    type: File
    inputBinding:
      prefix: -f 
      separate: true
      position: 1
  in_file_2:
    type: File
    inputBinding:
      prefix: -r 
      separate: true
      position: 2
  out_file_1:
    type: string
    inputBinding:
      prefix: -o
      position: 3
  out_file_2:
    type: string
    inputBinding:
      prefix: -p 
      position: 4
outputs:
  out_file_1_output:
    type: File
    outputBinding:
      glob: $(inputs.out_file_1)
  out_file_2_output:
    type: File
    outputBinding:
      glob: $(inputs.out_file_2)
  example_out:
    type: stdout
stdout: output.txt
