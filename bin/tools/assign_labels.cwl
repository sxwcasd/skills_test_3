#!/usr/bin/env cwl-runner

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

  merged_df:
    type: File
    inputBinding:
      prefix: --merged_df
      position: 2

outputs:
  populations:
    type: File
    outputBinding:
      glob: "Populations.txt"

baseCommand: [python3]
