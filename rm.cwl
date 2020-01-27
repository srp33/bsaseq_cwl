#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: rm
requirements:
  - class: DockerRequirement
    dockerPull: phusion/baseimage:master-amd64
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.the_file)
        writable: true
inputs:
  the_file:
    type: File
    inputBinding:
      prefix: -f
      position: 1
outputs:
  output: stdout
stdout: output.txt
