cwlVersion: v1.0
doc: Visualizes estimated ancestry PCs
class: Workflow

inputs:
  assign_label:
    type: File
  pca_ancestry:
    type: File
  ref_labels:
    type: File
  ref_pcs:
    type: File
  ancestries:
    type:
      type: array
      items: File

outputs:
  merged_ancestries:
    type: File
    outputSource: visualize_ancestries/merged_pcs

  pc_plots:
    outputSource: visualize_ancestries/pc_plots
    type:
      type: array
      items: File

steps:
  sort_pca:
    run: ../tools/sort_pca.cwl
    in:
      ref_pcs: ref_pcs
    out: [ sorted_pcs ]

  sort_label:
    run: ../tools/sort_label.cwl
    in:
      ref_labels: ref_labels
    out: [ sorted_label ]

  paste_pc_label:
    run: ../tools/paste_pc_label.cwl
    in:
      sorted_pcs: sort_pca/sorted_pcs
      sorted_label: sort_label/sorted_label 
    out: [ merged_refs ]

  visualize_ancestries:
    run: ../tools/visualize_ancestries.cwl
    in:
      script: pca_ancestry 
      merged_refs: paste_pc_label/merged_refs
      ancestry_pcs: ancestries
    out: [ pc_plots , merged_pcs]

  assign_labels:
    run: ../tools/assign_labels.cwl
    in:
      script: assign_label
      merged_df: visualize_ancestries/merged_pcs
    out: [ populations ] 
