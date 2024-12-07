cwlVersion: v1.0
class: CommandLineTool
id: bwa_record_se
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

inputs:
  ref_labels:
    type: File
    inputBinding:
      prefix: -k1
      position: 1

outputs:
  sorted_label:
    type: File
    outputBinding:
      glob: $(inputs.ref_labels.nameroot + "_sorted.txt")

baseCommand: [sort]
arguments:
  - valueFrom: $(inputs.ref_labels.nameroot + "_sorted.txt")
    shellQuote: false
    prefix: "| cut -f2 >"
    position: 2
