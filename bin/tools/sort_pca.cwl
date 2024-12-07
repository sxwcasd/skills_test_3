cwlVersion: v1.0
class: CommandLineTool
id: bwa_record_se
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

inputs:
  ref_pcs:
    type: File
    inputBinding:
      prefix: -k1
      position: 1

  output_name:
    type: string
    default: "sorted_ref_pca.tsv"
    inputBinding:
      prefix: -o
      position: 2

outputs:
  sorted_pcs:
    type: File
    outputBinding:
      glob: $(inputs.output_name)

baseCommand: [sort]
