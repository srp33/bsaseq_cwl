#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: tally_homozygous_windows
    dockerFile: |-
      FROM biocontainers/biocontainers:v1.0.0_cv4
      RUN conda install -c bioconda bedtools -y
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
    - entryname: parse_paths.py
      entry: |-
        data <- commandArgs()[7]

        ggplot(data, aes(x=position)) +
          geom_histogram(binwidth=1000000) +
          expand_limits(y=c(0,1000)) +
          scale_x_continuous(breaks = round(seq(min(0), max(chr1_final_NoWTHapmap$position), by=20000000), 10000000)) +
          theme(axis.text.x = element_text(angle = 70, hjust = 1)) +
          theme_bw()
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
