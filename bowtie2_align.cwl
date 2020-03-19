#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  DockerRequirement:
    dockerImageId: bowtie2_align
    dockerFile: |-
      FROM biocontainers/biocontainers:v1.0.0_cv4
      RUN conda install -c bioconda bowtie2 samtools -y
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
inputs:
  fasta_dir:
    type: Directory
  fasta_prefix:
    type: string
  fasta_file_extension:
    type: string
  fastq_file_1:
    type: File
  fastq_file_2:
    type: File
  out_bam_file_name:
    type: string
  threads:
    type: int
outputs:
  example_out:
    type: stdout
  out_files:
    type:
      type: array
      items: File
    outputBinding:
      glob: "$(inputs.out_bam_file_name)*"
stdout: output.txt
arguments:
    - shellQuote: false
      valueFrom: >
        FASTA_FILE=$(inputs.fasta_dir.path)/$(inputs.fasta_prefix)$(inputs.fasta_file_extension)
        SAM_FILE=$(runtime.tmpdir)/$(inputs.out_bam_file_name).sam

        bowtie2
        -x "$(inputs.fasta_dir.path)/$(inputs.fasta_prefix)"
        --phred33
        -1 "$(inputs.fastq_file_1.path)"
        -2 "$(inputs.fastq_file_2.path)"
        -S "\${SAM_FILE}"
        --threads $(inputs.threads)

        samtools sort \${SAM_FILE} -o $(inputs.out_bam_file_name)

        samtools index $(inputs.out_bam_file_name)
