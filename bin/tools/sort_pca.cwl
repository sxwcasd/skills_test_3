cwlVersion: v1.0
class: CommandLineTool
id: sort_pcs
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

inputs:
  ref_pcs:
    type: File
    inputBinding:
      prefix: -k1
      position: 1

outputs:
  sorted_pcs:
    type: File
    outputBinding:
      glob: $(inputs.ref_pcs.nameroot + ".sorted.txt")

baseCommand: [sort]
arguments:
  - valueFrom: $(inputs.ref_pcs.nameroot + ".sorted.txt")
    prefix: -o
    separate: true
