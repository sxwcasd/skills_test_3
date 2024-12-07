class: CommandLineTool
cwlVersion: v1.0
doc: grap FREEMIX and merge outputs.
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement

inputs:
  raw_contamination:
    type: File 
  output_file:
    type: string
    default: "Contamination.txt"

outputs:
  contamination:
    type: File
    outputBinding:
      glob: $(inputs.output_file)

baseCommand: []
arguments:
  - position: 0
    shellQuote: false
    valueFrom: >-
      cut -f 1,7 $(inputs.raw_contamination.path) | grep -v SEQ_ID > $(inputs.output_file)

stdout: "extract_freemix.stdout"
stderr: "extract_freemix.stderr"
