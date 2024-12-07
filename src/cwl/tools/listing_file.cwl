cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_directory)

inputs:
  input_directory:
    type: Directory

baseCommand: [echo]

arguments:
  - valueFrom: $(inputs.input_directory.basename)

outputs:
  theBaseNameOfTheDirectory:
    type: string
    outputBinding:
      loadContents: true
      outputEval: $(inputs.input_directory.basename)
  fileList:
    type: File[]
    outputBinding:
      glob: $(runtime.outdir)/$(inputs.input_directory.basename)/*.cram
    secondaryFiles:
      - .crai