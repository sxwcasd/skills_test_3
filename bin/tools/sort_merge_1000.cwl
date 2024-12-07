cwlVersion: v1.0
class: CommandLineTool
id: sort and merge reference 1000 genome project 
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
    expressionLib:
      $import: ./expression_lib.cwl

inputs:
  ref_pcs:
    type: File
    inputBinding:
      prefix: sort -k1
      position: 2

  ref_population_labels:
    type: File
    inputBinding:
      prefix: sort -k1
      position: 1

  OUTBAM:
    type: string
    inputBinding:
      prefix: OUTPUT=
      separate: false

outputs:
  OUTPUT:
    type: File
    outputBinding:
      glob: $(inputs.OUTBAM)

baseCommand: [paste]
