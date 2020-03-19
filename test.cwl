#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
    - entryname: parse_paths.py
      entry: |-
        import json, sys

        for d in json.loads(sys.argv[1]):
            print(d["path"])
inputs:
  main_vcf_file:
    type: File
  subtract_vcf_files:
    type:
      type: array
      items: File
outputs:
  example_out:
    type: stdout
stdout: output.txt
arguments:
    - shellQuote: false
      valueFrom: >
        for f in `python3 parse_paths.py '$(inputs.subtract_vcf_files)'`;
        do
          echo \${f};
        done
