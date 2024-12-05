class: CommandLineTool
cwlVersion: v1.0

inputs:
  individual_cram:
    type: File
    secondaryFiles: [.crai]
    inputBinding:
      prefix: --BamFile
      position: -1
  svd_prefix:
    type: string
    inputBinding:
      prefix: --SVDPrefix
      position: 1
  reference:
    type: File
    inputBinding:
      prefix: --Reference
      position: 2
  pc_number:
    type: int
    default: 4
    inputBinding:
      prefix: --NumPC
      position: 3

outputs:
  ancestries:
    type: File
    outputBinding:
      glob: "*.Ancestry"

  contaminations:
    type: File
    outputBinding:
      glob: "*.selfSM"

baseCommand: [/mnt/SCRATCH/linghao/cerc_assignment/VerifyBamID/bin/VerifyBamID]