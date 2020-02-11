#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/varscan:2.4.4--0
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
arguments:
    - shellQuote: false
      valueFrom: >
        TEMP_FILE=/tmp/varscan.out

        varscan mpileup2cns
        "$(inputs.in_file.path)"
        --min-coverage
        4
        --min-var-freq
        0.5
        --p-value
        0.99
        > \${TEMP_FILE}

        awk '{if ($4=="C" && $5=="T") print $0; else if ($4=="G" && $5=="A") print $0 }'
        \${TEMP_FILE}
        > "$(runtime.outdir)/$(inputs.out_file_name)"
inputs:
  in_file:
    type: File
  out_file_name:
    type: string
outputs:
  example_out:
    type: stdout
  out_files:
    type: File
    outputBinding:
      glob: "$(inputs.out_file_name)*"
stdout: output.txt
