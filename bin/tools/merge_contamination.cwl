cwlVersion: v1.0
class: CommandLineTool
doc: Use paste to merge files horizontally.
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

inputs:
  individual_contamination:
    type:
      type: array
      items: File

  output_file:
    type: string
    default: "raw_ontamination.txt"
    inputBinding:
      shellQuote: false
      prefix: ">"
      position: 2

outputs:
  merged_file:
    type: File
    outputBinding:
      glob: $(inputs.output_file)

baseCommand: []
arguments:
  - shellQuote: false
    position: 1
    valueFrom: >-
      cat $(inputs.individual_contamination.map(file => file.path).join(' '))

stdout: "merge_contamination.stdout"
stderr: "merge_contamination.stderr"
