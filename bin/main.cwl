cwlVersion: v1.0
class: Workflow
id: predict_label_from_pca

inputs:
  input_directory:
    type: Directory
  svd_prefix:
    type: string
  reference:
    type: File
  pc_number:
    type: int
    default: 4
  ref_labels:
    type: File
  ref_pcs: 
    type: File

outputs:
  pc_plots:
    outputSource: VisualizePc/pc_plots
    type:
      type: array
      items: File
  populations:
    type: File
    outputSource: VisualizePc/populations
  contamination:
    type: File
    outputSource: MergeContamination/merged_file

steps:
  EstimateContamination:
    run: ./subworkflows/estimate_contamination.cwl
    in:
      input_directory: input_directory
      svd_prefix: svd_prefix
      reference: reference
      pc_number: pc_number
    out: [ ancestry, contamination ]

  VisualizePc:
    run: ../subworkflows/visualize_pc.cwl
    in:
      ref_labels: 
      ref_pcs:  
      ancestries: EstimateContamination/ancestry
    out: [populations, pc_plots]