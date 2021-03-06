#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: subtract_variants
    dockerFile: |-
      FROM biocontainers/biocontainers:v1.0.0_cv4
      RUN conda install -c bioconda bedtools -y
  InlineJavascriptRequirement: {}
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
  out_file_name:
    type: string
outputs:
  example_out:
    type: stdout
  out_files:
    type: File
    outputBinding:
      glob: "$(inputs.out_file_name)"
stdout: output.txt
arguments:
    - shellQuote: false
      valueFrom: >
        HEADER_FILE=/tmp/header.vcf

        MAIN_FILE=/tmp/main.vcf

        TEMP_FILE=/tmp/temp.vcf

        grep "#" $(inputs.main_vcf_file.path) > \${HEADER_FILE}

        cp $(inputs.main_vcf_file.path) \${MAIN_FILE}

        for f in `python parse_paths.py '$(inputs.subtract_vcf_files)'`;
        do
          bedtools subtract -a \${MAIN_FILE} -b \${f} > \${TEMP_FILE};
          cat \${HEADER_FILE} \${TEMP_FILE} > \${MAIN_FILE}
        done

        cp \${MAIN_FILE} $(runtime.outdir)/$(inputs.out_file_name)
