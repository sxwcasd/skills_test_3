cwlVersion: v1.0
class: CommandLineTool
id: bwa_record_se
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

inputs:
  sorted_pcs:
    type: File
    inputBinding:
      position: 1

  sorted_label:
    type: File
    inputBinding:
      position: 2

  output_filename:
    type: string
    default: "merged_refs.txt"
    inputBinding:
      position: 3
      prefix: ">"
      shellQuote: false

outputs:
  merged_refs:
    type: File
    outputBinding:
      glob: $(inputs.output_filename)

baseCommand: [ paste ]
