class: CommandLineTool
cwlVersion: v1.0
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement

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
      glob: "$(inputs.individual_cram.nameroot).Ancestry"

  contaminations: 
    type: File
    outputBinding:
      glob: "$(inputs.individual_cram.nameroot).selfSM"

baseCommand: [/mnt/SCRATCH/linghao/cerc_assignment/VerifyBamID/bin/VerifyBamID]
arguments:
  - valueFrom: $(inputs.individual_cram.nameroot)
    prefix: --Output

stderr: verify_bam_id.stderr 
stdout: verify_bam_id.stdout
