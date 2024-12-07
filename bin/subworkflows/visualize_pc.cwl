cwlVersion: v1.0
doc: Visualizes estimated ancestry PCs
class: Workflow

inputs:
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
  pc_plots:
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
      merged_refs: paste_pc_label/merged_refs
      ancestry_pcs: ancestries
    out: [ png_list ]
