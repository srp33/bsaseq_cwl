#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: parse_variants
    dockerFile: |-
      FROM python:3.8.1-slim-buster

      RUN apt update \
       && apt install build-essential -y \
       && pip install cython numpy toolz dask pandas \
       && pip install scikit-allel
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
    - entryname: parse_variants.py
      entry: |-
        import allel
        import sys

        vcf_file_path = sys.argv[1]
        out_file_path = sys.argv[2]

        ann_df = allel.vcf_to_dataframe(vcf_file_path, fields='ANN', transformers=allel.ANNTransformer())
        ann_df.to_csv(out_file_path, sep="\t", index=False)
inputs:
  vcf_file:
    type: File
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
        python parse_annotated_variants.py $(inputs.vcf_file.path) $(runtime.outdir)/$(inputs.out_file_name)
