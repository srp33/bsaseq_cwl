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
inputs:
  main_vcf_file:
    type: File
  subtract_vcf_file_1:
    type: File
  subtract_vcf_file_2:
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
arguments:
    - shellQuote: false
      valueFrom: >
        TEMP_FILE1=/tmp/subtract1.vcf
        TEMP_FILE2=/tmp/subtract2.vcf
        TEMP_FILE3=/tmp/subtract3.vcf

        grep "#" $(inputs.main_vcf_file.path) > \${TEMP_FILE1}

        bedtools subtract -a $(inputs.main_vcf_file.path) -b $(inputs.subtract_vcf_file_1.path)
        > \${TEMP_FILE2}

        cat \${TEMP_FILE1} \${TEMP_FILE2} > \${TEMP_FILE3}

        bedtools subtract -a \${TEMP_FILE3} -b $(inputs.subtract_vcf_file_2.path)
        > \${TEMP_FILE2}

        cat \${TEMP_FILE1} \${TEMP_FILE2}
        > $(runtime.outdir)/$(inputs.out_file_name)
