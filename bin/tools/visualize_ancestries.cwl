cwlVersion: v1.0
class: CommandLineTool
id: plot_pcs_label_by_samples
requirements:
  - class: DockerRequirement
    dockerPull: sxwcasd/docker_playground
    

inputs:
  script:
    type: File
    inputBinding:
      position: 1

  merged_refs:
    type: File
    inputBinding:
      prefix: --merged_refs
      position: 2

  ancestry_pcs:
    type:
      type: array
      items: File
    inputBinding:
      prefix: --ancestry_pcs
      position: 3

outputs:
  pc_plots:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.png"

  merged_pcs:
    type: File
    outputBinding:
      glob: "*.tsv"

baseCommand: [python3]
