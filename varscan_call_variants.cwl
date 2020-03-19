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
        META_FILE=/tmp/meta
        HEADER_FILE=/tmp/head
        VARIANTS_FILE=/tmp/variants
        TEMP_FILE=/tmp/temp

        varscan mpileup2cns
        "$(inputs.in_file.path)"
        --min-coverage 8
        --min-var-freq 0.5
        --p-value 0.99
        --output-vcf
        --variants
        > \${TEMP_FILE}

        #--min-var-freq 0.5

        grep '^##' \${TEMP_FILE} > \${META_FILE}

        grep '^#CHROM' \${TEMP_FILE} > \${HEADER_FILE}

        # Filter for mutations most likely caused by EMS
        
        awk '{if ($4=="C" && $5=="T") print $0; else if ($4=="G" && $5=="A") print $0 }' \${TEMP_FILE}
        > \${VARIANTS_FILE}

        cat \${HEADER_FILE} \${VARIANTS_FILE} > \${TEMP_FILE}

        # For some reason, it puts columns for "Sample2" and "Sample3". The following command removes those columns and extra whitespace.
        
        awk -v OFS="\\t" '!/##/ {$11=$12="";print}' \${TEMP_FILE}
        | sed 's/^\s\+//g'
        | sed 's/[[:blank:]]*$//'
        > \${VARIANTS_FILE}

        cat \${META_FILE} \${VARIANTS_FILE} > "$(runtime.outdir)/$(inputs.out_file_name)"
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
