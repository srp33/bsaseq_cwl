#!/usr/bin/env cwl-runner

cwlVersion: v1.1
class: CommandLineTool
baseCommand: ["bash", "go.sh"]
requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerImageId: deleteme
    dockerFile: |-
      FROM phusion/baseimage:master-amd64
      RUN apt update; apt install wget
  InitialWorkDirRequirement:
    listing:
    - entryname: go.sh
      entry: |-
        LOCAL_FILE=$TMPDIR/`basename $(inputs.file_url)`

        wget -O $LOCAL_FILE $(inputs.file_url)
        gunzip -c $LOCAL_FILE > $(runtime.outdir)/$(inputs.out_file_name)
inputs:
  file_url:
    type: string
    inputBinding:
      position: 1
  out_file_name:
    type: string
outputs:
  out_file:
    type: File
    outputBinding:
      glob: $(inputs.out_file_name)
